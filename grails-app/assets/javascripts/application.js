// This is a manifest file that'll be compiled into application.js.
//
// Any JavaScript file within this directory can be referenced here using a relative path.
//
// You're free to add application-wide JavaScript to this file, but it's generally better
// to create separate JavaScript files as needed.
//
//= require jquery-3.2.1.min
//= require popper.min
//= require bootstrap
//= require core-ui
//= require skel.min
//= require util
//= require mail
//= require modernizr.custom
//= require classie
//= require dialog-box
//= require bootstrap-maxlength
//= require popper
//= require jquery.searchable-1.1.0.min
//= require_tree .
//= require_self

if (typeof jQuery !== 'undefined') {
    (function($) {
        $(document).ajaxStart(function() {
            $('#spinner').fadeIn();
        }).ajaxStop(function() {
            $('#spinner').fadeOut();
        });
    })(jQuery);
}


