/*
 * Datepicker
 */
(function($) {
  $(document).ready(function() {
    $("#submission_start_time").datetimepicker({
      dateFormat: "yy-mm-dd"
    });
  });
})(jQuery);

/*
 * Professor typeahead
 */
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