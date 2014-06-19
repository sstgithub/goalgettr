(function($) {
  $.fn.time_chooser = function() {
    return this.each(function(){
      var selectorator = $(this);
      
      updateSelectedTimeBox(selectorator);
      
      // update the form fields according to the user's chosen click
      selectorator.find('div').click(function() {
        var est_time;
        
        // HACKEY
        if ($(this).hasClass('less_10')) {
          est_time = '10';
        } else if ($(this).hasClass('less_30')) {
          est_time = '30';
        } else if ($(this).hasClass('less_60')) {
          est_time = '60';
        } else if ($(this).hasClass('less_180')) {
          est_time = '180';
        }
        	else if ($(this).hasClass('less_300')) {
        	est_time = '300';
        	}
        
        selectorator.parent().find('#task_est_time').val(est_time);
        
        updateSelectedTimeBox(selectorator);
      });
    });
    
    function updateSelectedTimeBox(selectorator) {
      selectorator.find('div').removeClass('selected');
      
      // set the selected est time
      var est_time = selectorator.parent().find('#task_est_time').val();
      var selectoring = '.less_' + est_time;
      selectorator.find(selectoring).addClass('selected');
    }    
  };
}(jQuery));


$( document ).ready(function() {
    $('.time_chooser').time_chooser();
    console.log( "readying!" );
});

