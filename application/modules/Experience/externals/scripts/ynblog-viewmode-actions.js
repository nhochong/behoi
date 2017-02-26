function experienceRenderViewMode(identity, default_view_mode, available_modes) {
    var myCookieViewMode = getCookie('experience-modeview-' + identity);
    if ( myCookieViewMode == '' || available_modes.indexOf(myCookieViewMode.split(/[-_]/)[1]) == -1) {
        myCookieViewMode = 'experience_' + default_view_mode + '-view';
    }

    $$('#experience-view-mode-button-' + identity + ' > span[rel=' + myCookieViewMode + ']').addClass('active');
    $$('#experience-content-mode-views-' + identity).addClass(myCookieViewMode);

    // Set click viewMode
    $$('#experience-view-mode-button-' + identity + ' > span').addEvent('click', function(){
        var viewmode = this.get('rel');
        var content = $('experience-content-mode-views-' + identity);

        setCookie('experience-modeview-' + identity, viewmode, 1);

        // set class active
        $$('#experience-view-mode-button-' + identity + ' > span').removeClass('active');
        this.addClass('active');

        content
            .removeClass('experience_list-view')
            .removeClass('experience_grid-view');

        content.addClass( viewmode );
    });
}