$(document).ready(function () {
	$('.generate-code').click(function(){
		$.ajax({
			url: '/teachers/classrooms/regenerate_code',
			success: function(data, status, jqXHR) {
				$('.class-code').val(data.code);
			}
		});
	});


	if ($("#classroom_code").length > 0) {

		//on gradelevel having a non-default value move to generate a new code 

		guiders.createGuider({
			attachTo: ".generate-code",
			buttons: [{name: "Next"}],
			description: "Share this class code with your students to have them join your class",
			id: "first",
			position: 3,
			next: "second",
			title: "Sharing Your Classcode"
		}).show();


		guiders.createGuider({
			buttons: [{name: "Close, then click on the clock.", onclick: guiders.hideAll}],
			description: "Custom event handlers can be used to hide and show guiders. This allows you to interactively show the user how to use your software by having them complete steps. To try it, click on the clock.",
			id: "second",
			next: "fourth",
			position: 2,
			title: "You can also advance guiders from custom event handlers.",
			width: 450
		});
	}
});
