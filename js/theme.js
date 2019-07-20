$(function () {

    positionFooter();
    $(window).resize(positionFooter);
    setInterval(positionFooter, 250);

    function positionFooter() {
        var $footer = $('.footer');
        var _fixed = 'navbar-fixed-bottom';
        
        if ($(window).height() > getBottom($footer)) {
            $footer.addClass(_fixed);
        } else {
            $footer.removeClass(_fixed);
        }
    
        function getBottom($el) {
            return $el.offset().top + $el.outerHeight(true);
        }
    }

});