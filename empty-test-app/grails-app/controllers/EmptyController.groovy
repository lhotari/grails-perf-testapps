class EmptyController {
	int counter

   def index = {
   	if(counter++ % 10 == 0) {
   		try {
   		  throw new RuntimeException('#fail')
   		} catch (e) {}
   	}
	render text:actionUri, contentType:'text/plain'
	return null
   }
}
