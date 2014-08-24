// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require bootstrap-sprockets

function submitForm(formID) {
    document.getElementById(formID).submit();
    return false;
};

/*
 * All sites
 */
$(function () {

    $(document).on('submit', 'form.get-json', function (e) {

        $(this).attr('disabled', true);

        e.preventDefault(); //Prevent the normal submission action
        var form = $(this);
        var formData = form.serializeArray();

        /* get button info from clicked button */
        var clicked = $("button[clicked=true], input[type=submit][clicked=true]");
        formData.push({ name: clicked.name, value: clicked.value });

        /* set the url */
        var url = $(this).attr('action');
        if ($(clicked).attr('formaction')) {
            url = $(clicked).attr('formaction');
        }

        var posting = $.ajax({
            type: "POST",
            url: url,
            data: formData,
            dataType: "json"
        });

        /* Put the results in divs */
        posting.success(function (json) {

            $.each(json, function (index, data) {
                if (data['mode'] == 'html') $(data['target']).html(data['html']);
                if (data['mode'] == 'append') $(data['target']).append(data['html']);
                if (data['mode'] == 'prepend') $(data['target']).prepend(data['html']);
            });

        });

        clicked.removeAttr("clicked");

        return false;
    });

    $(document).on('submit', 'form.intercept-post', function (e) {

        $(this).attr('disabled', true);

        e.preventDefault(); //Prevent the normal submission action
        var form = $(this);
        var formData = form.serializeArray();

        /* get button info from clicked button */
        var clicked = $("button[clicked=true], input[type=submit][clicked=true]");
        formData.push({ name: clicked.name, value: clicked.value });

        /* set the url */
        var url = $(this).attr('action');
        if ($(clicked).attr('formaction')) {
            url = $(clicked).attr('formaction');
        }

        /* create target array and auto-add the admin flash area */
        var targets = $(this).attr('targets');
        if ($(clicked).attr('targets')) {
            targets = $(clicked).attr('targets');
        }
        targets = $.map(targets.split(","), $.trim); //trim whitespace
        targets.splice(0, 0, '#target-admin-flash');

        /* show loading image in each area */
        for (x in targets) {
            //$(targets[x]).prepend("<img class='loading' src='"+GetSiteRoot()+"/js/load.gif' alt='loading...' />");
            $(targets[x]).prepend('<img class="loading" src="/assets/all/js/load.gif" alt="loading..." />');
            $(targets[x]).addClass('faded');
        }

        /* Send the data using post */
        var posting = $.post(url, formData);

        /* Put the results in divs */
        posting.done(function (data) {
            for (x in targets) {
                $(targets[x]).removeClass('faded');
                var content = $(data).find(targets[x]);
                $(targets[x]).empty().append(content.html());
            }
        });
        if ($('#dialog').hasClass('ui-dialog-content')) $("#dialog").dialog('close');
        clicked.removeAttr("clicked");
        return false;
    });


});