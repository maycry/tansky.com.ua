function ready() {
	$('#post_image_attributes').fileupload({
		dataType: "script"
		})

	function getMatches(string, regex, index) {
    index || (index = 1); // default to the first capturing group
    var matches = [];
    var match;
    while (match = regex.exec(string)) {
        matches.push(match[index]);
    }
    return matches;
	}

	textareaText = $("#post_body").val()
	if (textareaText != undefined) {
		textareaImages = getMatches(textareaText, regex, 1);
		if(textareaImages != null){
			textareaImages.map(function(item){
				$("#thumbs").append("<img width='70' src='"+ item +"'>")
			});
		}
	};

};

$(document).ready(ready)
$(document).on('page:load', ready)