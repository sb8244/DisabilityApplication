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
//= require bootstrap
//= require_tree .

(function($) {
  $(document).ready(function() {
    var nameSource = function(query, cb) {
      $.get('/professors/list?name=' + query, function(data) {
        cb(processData(data));
      });
    };
    var emailSource = function(query, cb) {
      $.get('/professors/list?email=' + query, function(data) {
        cb(processData(data));
      });
    };

    $("#submission_professor_name").typeahead(null,{
      source: nameSource,
      displayKey: 'name',
    }).on('typeahead:selected', function (obj, datum) {
      $("#submission_professor_email").typeahead('val', datum.email).typeahead('close');
    });

    $("#submission_professor_email").typeahead(null,{
      source: emailSource,
      displayKey: 'email',
    }).on('typeahead:selected', function (obj, datum) {
      $("#submission_professor_name").typeahead('val', datum.name).typeahead('close');
    });

    function processData(data) {
      var names = [];
      for(var i = 0; i < data.length; i++) {
        names.push({
          email: data[i].email,
          name: data[i].name
        });
      }
      return names;
    }
  });
})(jQuery);