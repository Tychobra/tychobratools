#' Deploy Shiny application
#'
#' Deploy a Shiny application to a GCP VM instance (Must have gcloud on local machine).
#' Currently, this function MUST be run with the application in a `shiny_app` directory, &
#' that directory should be in the Current Working Directory.
#'
#' @param deployment_type Name of configuration in `config.yml` to use for deployed app
#' @param deployed_dir_name Name of the directory in the VM instance for this app
#' @param instance_name The name of the VM instance
#' @param project_id The name of the GCP project for this VM instance
#' @param project_zone The zone of the GCP project for this VM instance
#' @param gcloud Absolute path for gcloud CLI (Ex: `/usr/local/bin/google-cloud-sdk/bin`)
#'
#'
#' @export
#'
#' @examples
#'
#' \dontrun{
#'   deploy_app(
#'     deployment_type = 'production',
#'     deployed_dir_name = 'example_app',
#'     instance_name = 'instance-1',
#'     project_id = 'gcp-project-id',
#'     project_zone = 'us-east1-d',
#'     gcloud = '/usr/local/bin/google-cloud-sdk/bin'
#'   )
#' }
#'
#'
deploy_app <- function(
  deployment_type,
  deployed_dir_name,
  instance_name,
  project_id,
  project_zone,
  gcloud = NULL
) {

  if (!is.null(gcloud)) {
    Sys.setenv(PATH = paste(Sys.getenv('PATH'), gcloud, sep = ":"))
  }

  if (is.null(deployment_type)) {
    stop("Argument `deployment_type` is NULL")
  }
  
  if (is.null(deployed_dir_name)) {
    stop("Argument `deployed_dir_name` is NULL")
  }

  cat("Writing R Environment file...\n")
  
  # create `.Renviron` file to set configuration
  config_type <- paste0("R_CONFIG_ACTIVE=", deployment_type)
  
  app_files <- list.files(path = 'shiny_app', all.files = TRUE)
  # Check if .Renviron file already exists. If so, add R_CONFIG_ACTIVE to file
  if (".Renviron" %in% app_files) {
    hold_r_environ <- read.delim2(file = 'shiny_app/.Renviron', header = FALSE, sep = "\n", stringsAsFactors = FALSE)
    write(config_type, file = "shiny_app/.Renviron", append = TRUE)
  } else {
    write(config_type, file = "shiny_app/.Renviron")
  }
  
  # create new "restart.txt" file so that the app automatically restarts once deployed
  write(NULL, file = "shiny_app/restart.txt")

  cat("Setting default GCP Project...\n")
  
  # gcloud so set the project
  command_set_proj <- paste0("gcloud config set project ", project_id)
  system(command_set_proj)

  cat("Removing old deployment directory...\n")

  # gcloud SSH command to remove app if it already exists
  command_1 <- paste0("if [ -d /srv/shiny-server/", deployed_dir_name, " ]; then sudo rm -rf /srv/shiny-server/", deployed_dir_name, "; fi")
  command_arg <- paste0('--command="', command_1, '"')
  system2("gcloud", args = c("compute", "ssh", instance_name, "--zone", project_zone, command_arg))

  cat("Creating new deployment directory...\n")

  # Create the target directory to copy into. This doesn't seem like it should be necessary,
  # but gcloud scp has a problem if it doesn't exist.
  command_mkdir = paste0('--command="mkdir /srv/shiny-server/', deployed_dir_name, '"')
  system2("gcloud", args = c("compute", "ssh", instance_name, "--zone", project_zone, command_mkdir))

  cat("Deploying application...\n")
  
  # gcloud SCP command to copy local contents in 'shiny_app' directory to new 'deployed_dir_name' directory in VM
  instance_command <- paste0('"', instance_name, ':/srv/shiny-server/', deployed_dir_name, '"')
  system2("gcloud", args = c("compute", "scp", "--recurse", "--scp-flag=shiny_app/.Renviron", file.path("shiny_app", "*"), instance_command, "--zone", project_zone))
  
  cat("Erasing local R Environment file...\n")
  
  file.remove('shiny_app/.Renviron')
  
  # If .Renviron file existed before, rewrite it
  if (".Renviron" %in% app_files) {
    for (line in hold_r_environ$V1) {
      write(line, file = 'shiny_app/.Renviron', append = TRUE)
    }
  }
  
  cat("Application deployed!")
}
