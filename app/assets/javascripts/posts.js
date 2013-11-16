function ready() {
	$('#post_image_attributes').fileupload({
		dataType: "script"
		})

	s = $("#post_body").val()
	if (s != undefined) {
		/*a = s.match(/!\(https:\/\/[-A-Z0-9+&@#\/%?=~_| !:,.;]*[A-Z0-9+&@#\/%=~_|]\)/gi);*/
		a = s.match(/!\[[-A-Z0-9+&@#\/%?=~_| !:,.;]*[A-Z0-9+&@#\/%=~_|]\]\(https:\/\/[-A-Z0-9+&@#\/%?=~_| !:,.;]*[A-Z0-9+&@#\/%=~_|]\)/gi);
		if(a != null){
			a.map(function(item){
				img=item.match(/https:\/\/[-A-Z0-9+&@#\/%?=~_| !:,.;]*[A-Z0-9+&@#\/%=~_|]/gi);
				$("#thumbs").append("<img width='70' src='"+ img +"'>")
			});
		}
	};

};

$(document).ready(ready)
$(document).on('page:load', ready)