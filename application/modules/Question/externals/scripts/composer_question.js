
Composer.Plugin.Question = new Class({

  Extends : Composer.Plugin.Interface,

  name : 'question',

  options : {
    title : 'Ask',
    lang : {},
    requestOptions : {getFormURL : en4.core.baseUrl + 'question/wall/getform'},
    fancyUploadEnabled : false,
    fancyUploadOptions : {}
  },

  initialize : function(options) {
    this.elements = new Hash(this.elements);
    this.params = new Hash(this.params);
    this.parent(options);
  },

  attach : function() {
    this.parent();
    this.makeActivator();
    return this;
  },

  detach : function() {
    this.parent();
    return this;
  },

  activate : function() {
    if( this.active ) return;
    this.parent();

    this.makeMenu();
    this.makeBody();

    this.getComposer().getForm().hide();
    this.makeLoading();
    var bind = this;
    new Request.HTML({
        method: 'get',
        url: this.options.requestOptions.getFormURL,
        data:{'subject' : en4.core.subject.guid},
        update:this.elements.body,
        onComplete:function(){
                bind.initform();
            }
        }
    ).send();
  },
  initform : function () {
    var form = this.elements.body.getFirst('form');
    form.addEvent('submit', function (){return false;})
    var form_request = new Form.Request(form, this.elements.body);
    form_request.addEvent('success', function() {
                                                this.initform();
                                              }.bind(this));
    form.getElement('button[id=submit]').addEvent('click', function() {
                                                                        form.getElement('textarea[id=question]').set('value', tinyMCE.get('question').getContent());
                                                                      })
    form_request.addEvent('send', function() {
                                        this.elements.loading = null;
                                        this.makeLoading();
                                        this.elements.loading.replaces(form.getElement('button[id=submit]'));
                                       }.bind(this));
  },
  deactivate : function() {
    if( !this.active ) return;
    this.getComposer().getForm().show();
    this.parent();
  },

  doRequest : function() {
    this.elements.iframe = new IFrame({
      'name' : 'composePhotoFrame',
      'src' : 'javascript:false;',
      'styles' : {
        'display' : 'none'
      },
      'events' : {
        'load' : function() {
          this.doProcessResponse(window._composePhotoResponse);
          window._composePhotoResponse = false;
        }.bind(this)
      }
    }).inject(this.elements.body);

    window._composePhotoResponse = false;
    this.elements.form.set('target', 'composePhotoFrame');

    // Submit and then destroy form
    this.elements.form.submit();
    this.elements.form.destroy();

    // Start loading screen
    this.makeLoading();
  },

  doProcessResponse : function(responseJSON) {
    // An error occurred
    if( ($type(responseJSON) != 'hash' && $type(responseJSON) != 'object') || $type(responseJSON.src) != 'string' || $type(parseInt(responseJSON.photo_id)) != 'number' ) {
      //this.elements.body.empty();
      this.makeError(this._lang('Unable to upload photo. Please click cancel and try again'), 'empty');
      return;
      //throw "unable to upload image";
    }

    // Success
    this.params.set('rawParams', responseJSON);
    this.params.set('photo_id', responseJSON.photo_id);
    this.elements.preview = Asset.image(responseJSON.src, {
      'id' : 'compose-photo-preview-image',
      'class' : 'compose-preview-image',
      'onload' : this.doImageLoaded.bind(this)
    });
  },

  doImageLoaded : function() {
    if( this.elements.loading ) this.elements.loading.destroy();
    if( this.elements.formFancyContainer ) this.elements.formFancyContainer.destroy();
    this.elements.preview.erase('width');
    this.elements.preview.erase('height');
    this.elements.preview.inject(this.elements.body);
    this.makeFormInputs();
  },

  makeFormInputs : function() {
    this.ready();
    this.parent({
      'photo_id' : this.params.photo_id
    });
  }

})