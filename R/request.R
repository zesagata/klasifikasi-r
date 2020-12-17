#'Request client token
#'
#'Use this function to request client data
#'
#'@param client_data list of clientId & clientSecret
#'@param cfg list of package options, created by created by [config()]
#'@export
#'@examples
#'client_data = list(
#'  clientId = 'clientid',
#'  clientSecret = 'clientSecret
#')
#'client_token <- request_token(client_data, config())
request_token <- function(client_data, cfg) {
  url <- cfg['url']
  fullUrl <- paste(url, "/api/v1/auth/token", sep="")

  r <- httr::POST(url = fullUrl, body = client_data, encode = 'json')
  response_body <- httr::content(r, "parsed")
  response_code <- httr::status_code(r)

  return(list(body = response_body, code = response_code))
}

#' Get model data
#'
#' Use this function to get model data based on client token
#' @param client_token client token, created by [request_token()$body]
#' @cfg list of package options, created by [config()]
#' @export
#'
get_model_data <- function (client_token, cfg) {
  url <- cfg['url']
  fullUrl <- paste(url, "/api/v1/auth/activeClient", sep="")
  auth <- paste("Bearer", client_token$auth$token, sep=" ")

  r <- httr::GET(url = fullUrl, httr::add_headers(Authorization = auth))
  response_body <- httr::content(r, "parsed")
  response_code <- httr::status_code(r)

  return (list(body = response_body, code = response_code))
}