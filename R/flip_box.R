#' flip_button_front
#'
#' button to flip to the front of the flip_box
#'
#' @param id the flipbox id
#' @param text the button text
#'
#' @export
#'
#' @importFrom htmltools tags
#'
flip_button_front <- function(id, text) {
  tags$button(
    id = paste0("btn-flip-front-", id),
    class = "btn btn-primary btn-rotate",
    text
  )
}


#' flip_button_back
#'
#' button to flip to the back of the flip_box
#'
#' @param id the flipbox id
#' @param text the button text
#'
#' @export
#'
#' @importFrom htmltools tags
#'
flip_button_back <- function(id, text) {
  tags$button(
    id = paste0("btn-flip-back-", id),
    class = "btn btn-primary btn-rotate",
    text
  )
}


#' flip_box
#'
#' ui for the flip_box_ui
#'
#' @param id the flipbox id
#' @param front_content ui for the front of the flip box
#' @param back_content ui for the back of the flip box
#'
#' @export
#'
#' @importFrom htmltools tagList tags
#' @importFrom shiny singleton
#'
#'
flip_box <- function (
  id,
  front_content = h1("Hi From the Front"),
  back_content = tags$div(
    style = "background-color: #FFF; height: 380px; margin-top: -20px;",
    h1("Hi From the back"),
  )
) {
  if (is.null(id))
    stop("card id cannot be null and must be unique")

  tagList(
    tags$div(
      class = "rotate-container",
      tags$div(
        class = paste0("card-front-", id),
        style = "background-color: white;",
        front_content
      ),
      tags$div(
        class = paste0("card-back-", id),
        back_content
      )
    ),
    tagList(
      shiny::singleton(
        tags$head(
          tags$style(
            paste0(
              "/* Card styles for rotation */

             .rotate-container {
                position: relative;
            }

            .rotate-container .card-front-", id, ", .rotate-container .card-back-", id, " {
              width: 100%;
              height: 100%;
              -webkit-transform: perspective(600px) rotateY(0deg);
              transform: perspective(600px) rotateY(0deg);
              -webkit-backface-visibility: hidden;
              backface-visibility: hidden;
              transition: all 0.5s linear 0s;
            }

            .card .card-background-", id, " {
              height: 1em
            }

            .rotate-container .card-back-", id, " {
              -webkit-transform: perspective(1600px) rotateY(180deg);
              transform: perspective(1600px) rotateY(180deg);
              position: absolute;
              top: 0;
              left: 0;
              right: 0;
            }

            .rotate-container .rotate-card-front-", id, " {
              -webkit-transform: perspective(1600px) rotateY(-180deg);
              transform: perspective(1600px) rotateY(-180deg);
            }

            .rotate-container .rotate-card-back-", id, " {
              -webkit-transform: perspective(1600px) rotateY(0deg);
              transform: perspective(1600px) rotateY(0deg);
            }

          "
            )
          ),
          tags$script(
            paste0(
              "$(function() {

                // For card rotation
                $('#btn-flip-front-", id, "').click(function(){
                  $('.card-front-", id, "').addClass(' rotate-card-front-", id, "');
                  $('.card-back-", id, "').addClass(' rotate-card-back-", id, "');
                });

                $('#btn-flip-back-", id, "').click(function(){

                  $('.card-front-", id, "').removeClass(' rotate-card-front-", id, "');
                  $('.card-back-", id, "').removeClass(' rotate-card-back-", id, "');
                });

              });"
            )
          )
        )
      )
    )
  )
}
