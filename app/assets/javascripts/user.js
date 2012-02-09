$(document).ready(function() {
    $(".current-status").click(function(event){
        $(this).toggle();
        $(this).parent().find(".status-editable-container").toggle();
    });

    $(".status-cancel-edit").click(function(event){
        event.preventDefault();
        $(this).parents(".status-container").find(".current-status").toggle();
        $(this).parents("form").toggle();
    });

    $(".status-editable-container :submit").click(function(event){
        event.preventDefault();
        var form = $(this).parents("form");
        $.ajax({
           url: $(form).attr("action"),
           type: "PUT",
           dataType: "JS",
           data: $(form).serialize()
        });

        var statusSpan = $(this).parents(".status-container").find(".current-status");
        var newValue = $(form).find(".status-editable").val();
        if(newValue == ""){
            newValue = "Click to change status";
        }
        $(statusSpan).html(newValue);
        form.hide();
        statusSpan.show();
    });

    $(".edit-container :submit").click(function(event){
        event.preventDefault();
        var form = $(this).parents("form");
        $.ajax({
           url: $(form).attr("action"),
           type: "PUT",
           dataType: "JS",
           data: $(form).serialize()
        });
    });
});