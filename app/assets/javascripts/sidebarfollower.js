var publish_controls_fixed = false;
$(document).ready(function() {
  var orig_sidebar_top = $('#sidebar_follower .shareholder').position().top;
  $(window).scroll( function() {
    var viewportHeight = parseInt( $( window ).height() );
    var pageScroll = parseInt( $(document).scrollTop() );
    //var content_y = $('div.add_edit_forms').offset().top + $('div.add_edit_forms').height();
    var global_wrapper_top = $('#contentwrapper').position().top;
    //console.log(pageScroll + ' - ' + global_wrapper_top);
    /*
    if (pageScroll > (global_wrapper_top + 20)) {
    collapse_header();
    }
    */
    share_button_positioning();
    //console.log( pageScroll + ' - ' + $('div.footer').position().top );
    if ( pageScroll > ($('footer').position().top - 280) ) {
      if (publish_controls_fixed) {
        $('#sidebar_follower').css({
          position: 'absolute'
          ,top: '0'
        });
        $('#sidebar_follower .shareholder').css({
          top: ($('footer').position().top - 615) + 'px'
        });
        $('#gallerytemplate #sidebar_follower .shareholder').css({
          top: ($('footer').position().top - 565) + 'px'
        });
        publish_controls_fixed = false;
      }
    } else if (pageScroll > ($('#contentwrapper').position().top + orig_sidebar_top - 20) ) {
      $('#sidebar_follower').css({
        position: 'fixed'
        ,top: '0'
      });
      $('#sidebar_follower .shareholder').css({
        top: '20px'
      });
      publish_controls_fixed = true;
    } else {
      if (publish_controls_fixed) {
        $('#sidebar_follower').css({
          position: 'absolute'
          ,top: '0'
        });
        $('#sidebar_follower .shareholder').css({
          top: orig_sidebar_top + 'px'
        });
        publish_controls_fixed = false;
      }
    }
  });
  forbes_window_resizing();
  // window resizing
  $(window).resize(function() {
    forbes_window_resizing();
  });
  // share button positioning
  $('#sharebutton').click(function(){
    share_button_positioning();
  });
});
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
function forbes_window_resizing() {
  if ( $( window ).width() < 1160 ) {
    $('#sidebar_follower').hide();
    $('#abovefold .shareholder').show();
  } else {
    $('#sidebar_follower').show();
    $('#abovefold .shareholder').hide();
  }
  //console.log( $( window ).width() );
}
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
function share_button_positioning() {
  if (publish_controls_fixed) {
    $('#stwrapper').css({
      'top' : parseInt( $('#sidebar_follower').offset().top + 190 ) + 'px'
    });
  }
}
