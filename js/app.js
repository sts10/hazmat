$(document).ready(function(){

  var post_index = -1;
  var addressValue = '';

  // listens for any navigation keypress activity
  $(document).keydown(function(e){

    // if all text boxes are out of focus...
    if ($("input").is(':focus') == false && $("textarea").is(':focus') == false) {

      switch(e.which) {

        // code look-up: http://www.cambiaresearch.com/articles/15/javascript-char-codes-key-codes

        // case 38: // up
        case 75: // k
        case 80: // p
          Navigate(-1);
        break;

        // case 40: // down
        case 74: // j
        case 78: // n
          console.log('down');
          Navigate(1);
        break;

        case 77: // m
          scrollPost(-1);
        break;

        case 188: // , 
          scrollPost(1);
        break;

        case 13: // enter/return/carriage return
          window.location.href = addressValue;
        break; 

        default: return; // exit this handler for other keys
      }
      e.preventDefault(); // prevent the default action (scroll / move caret)
    }
  });


  var Navigate = function(diff) {
      post_index += diff;
      var post_list = $(".blog_post");
      if (post_index >= post_list.length){
           post_index = 0;
      }
      if (post_index < 0){
           post_index = post_list.length - 1;
      }

      // apply css class to selected post, and remove it from all other posts
      var cssClass = "selected_post";
      post_list.removeClass(cssClass).eq(post_index).addClass(cssClass);

      // scroll body to the selected post
      $('html, body').animate({
          scrollTop: $(".selected_post").offset().top - 100
      }, 20);

      // put the selected post in focus
      $('.selected_post').focus();

      // set global variable addressVariable to the address of the selected post
      addressValue = $(".selected_post a.permalink").attr("href");
  };


  var scrollPost = function(diff) {
    if (diff == -1) { // m down
      $('.selected_post').animate({
        // scrollTop: 10;
        // console.log('you hit m');
      });
    } 

  };

  // on window resize
  // $( window ).resize(function() {
    // console.log("window bheing resized");
    // var window_height = $( window ).height();
    // console.log('window height is now' + window_height);
    // $('.blog_post').attr('max-height', window_height - 80 + 'px');
  // });

});
