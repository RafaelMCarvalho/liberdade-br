//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require jquery.bxSlider.min

/* Main navigation */

$(function () {
    $("#main_navigation .donate_item, #main_navigation .share_item").click(
        function () {
            if ($(this).hasClass("active")) {
                $(this).removeClass("active");
            } else {
                $("#main_navigation > li").removeClass("active");
                $(this).addClass("active");
            }
        }
    );
});

/* Banner */

var banner_image_sld, banner_info_sld;

$(function () {
    banner_image_sld = $("#banner ul.images").bxSlider({
        auto: true, controls: false, pause: 6000,
        onBeforeSlide: function (curr_sld_num, slt_qty, curr_html) {
            $("#banner .controls > span").removeClass("active");
            $($("#banner .controls > span")[curr_sld_num]).addClass("active");
        }
    });
});

$(function () {
    banner_info_sld = $("#banner .infos ul").bxSlider({
        auto: true, controls: false, mode: "fade", pause: 6000
    });
});

$(function () {
    $("#banner .controls > span").click(function () {
        var slide_pos = $(this).index();

        $("#banner .controls > span").removeClass("active");
        $(this).addClass("active");
        banner_image_sld.goToSlide(slide_pos);
        banner_info_sld.goToSlide(slide_pos);
    });
});
