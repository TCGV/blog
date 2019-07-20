$(function () {

    positionFooter();
    $(window).resize(positionFooter);
    setInterval(positionFooter, 250);

    function positionFooter() {
        var $footer = $('.footer');
        var _fixed = 'navbar-fixed-bottom';
        
        if (Math.round($(window).height()) > Math.round(getBottom($footer))) {
            $footer.addClass(_fixed);
        } else {
            $footer.removeClass(_fixed);
        }
    
        function getBottom($el) {
            return parseInt($el.offset().top + $el.outerHeight());
        }
    }

});