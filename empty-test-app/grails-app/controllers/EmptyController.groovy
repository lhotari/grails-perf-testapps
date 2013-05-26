class EmptyController {
   def index = {
	render text:actionUri, contentType:'text/plain'
	return null
   }
}
