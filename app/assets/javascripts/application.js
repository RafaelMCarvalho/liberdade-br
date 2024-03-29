//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require jquery.bxSlider.min
//= require tinymce-jquery

/* Main navigation */

$(function () {
    $("#main_navigation .donate_item > a, #main_navigation .share_item > a").click(
        function () {
            if ($(this).parent().hasClass("donate_item")) {
                $("#main_navigation .share_item").removeClass("active");
            } else {
                $("#main_navigation .donate_item").removeClass("active");
            }

            if ($(this).parent().hasClass("active")) {
                $(this).parent().removeClass("active");
            } else {
                $(this).parent().addClass("active");
            }
        }
    );
});

/* Banner */

var banner_image_sld, banner_info_sld, partners_sld;

$(function () {
    if (!$("#banner_wrapper").hasClass('no_slide'))
      banner_image_sld = $("#banner ul.images").bxSlider({
          auto: true, controls: false, pause: 6000,
          onBeforeSlide: function (curr_sld_num, slt_qty, curr_html) {
              $("#banner .controls > span").removeClass("active");
              $($("#banner .controls > span")[curr_sld_num]).addClass("active");
          }
      });
});

$(function () {
    if (!$("#banner_wrapper").hasClass('no_slide'))
      banner_info_sld = $("#banner .infos ul").bxSlider({
          auto: true, controls: false, mode: "fade", pause: 6000
      });
});

$(function () {
    if (!$("#banner_wrapper").hasClass('no_slide'))
      $("#banner .controls > span").click(function () {
          var slide_pos = $(this).index();

          $("#banner .controls > span").removeClass("active");
          $(this).addClass("active");
          banner_image_sld.goToSlide(slide_pos);
          banner_info_sld.goToSlide(slide_pos);
      });
});

$(function () {
    partners_sld = $("#partners_list ul").bxSlider({
        auto: true, controls: false, pause: 6000, mode: 'fade'
    });
});

$(function () {
    $('#partners_list .next').click(function () {
        partners_sld.goToNextSlide();
    });
});

$(function () {
    $('#partners_list .previous').click(function () {
        partners_sld.goToPreviousSlide();
    });
});

/* Facebook Like box */

$(function () {
    var progress_bar = $('#facebook_box .facebook_progress_bar');
    if(progress_bar.length != 0) {
        var id = progress_bar.data('id');
        var goal = progress_bar.data('goal');

        $.getJSON('http://graph.facebook.com/' + id, function(data) {
            var likes = data.likes;
            var progress_width = progress_bar.width();
            if(likes < goal)
                progress_width = Math.round(likes * progress_bar.width() / goal);

            progress_bar.find('p').css('width', progress_width);
            progress_bar.find('span').text(likes);
        });
    }
});
