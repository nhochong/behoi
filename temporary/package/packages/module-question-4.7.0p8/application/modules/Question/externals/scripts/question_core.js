var searchTagAction = function(tag_id) {
    var tags = $('tags');
    tags.set('value', tag_id);
    tags.getParent('form').submit();
}
var pageAction = function(page) {
    $('page').value = page;
    $('filter_form').submit();
}

function order_action(order) {
    $('order').value = order;
    $('filter_form').submit();
}
var question_basic = new Class({
    Implements: [Options],
    options: {
        question_id: null,
        module: 'question',
        controller: 'ajax',
        lang: null
    },
    initialize: function(a) {
        this.setOptions(a);
    },
    getURL: function(action) {
        return en4.core.baseUrl + this.options.module + '/' + this.options.controller + '/' + action;
    },
    run_JSON: function(action, data, SuccessFunction) {
        new Request.JSON({
            'url': this.getURL(action),
            'data': $extend(data, {'isajax': true}),
            'onSuccess': function(responseObject) {
                if ($type(responseObject) != "object") {
                    alert('ERROR occurred. Please try againe.');
                    return false;
                }
                if (!responseObject.status || responseObject.status != true) {
                    if (responseObject.reload == true)
                        window.location.reload(true);
                    if (responseObject.error && $type(responseObject.error) == 'string') {
                        alert(responseObject.error);
                    }
                    return false;
                }
                if (responseObject.status == true) {
                    delete responseObject.status;
                    SuccessFunction(responseObject);
                    return false;
                }
            }.bind(this)
        }).send();
    }
});
var question = new Class({
    Extends: question_basic,
    answer_voite: function(answer_id, voite) {
        var voted_text = this.options.lang.voted;
        this.run_JSON('voite',
                {'task': 'voite',
                    'answer_id': answer_id,
                    'voite': voite
                },
        function(response) {
            var up_class = this.checkClass('up', voite);
            var d_class = this.checkClass('down', voite);
            
            $('answervoite_up_' + answer_id).set('html', '<span class="qa_like_btn"></span>').addClass(up_class).set('title', voted_text);
            $('answervoite_down_' + answer_id).set('html', '<span class="qa_unlike_btn"></span>').addClass(d_class).set('title', voted_text);
            $('answervoite_likes_' + answer_id).set('text', response.sum);
            new Tips($('answervoite_' + answer_id).getElements('.Tips'));
        }.bind(this));

    },
    question_voite: function(voite) {
        var voted_text = this.options.lang.voted;
        var obj_id = this.options.question_id;
        this.run_JSON('qvoite',
                {'task': 'voite',
                    'question_id': obj_id,
                    'voite': voite
                },
        function(response) {
            $('questionvoite_up_' + obj_id).set('html', '<span class="qa_like_btn"></span>').set('title', voted_text);
            var up_class = this.checkClass('up', voite);
            $('questionvoite_up_' + obj_id).addClass(up_class);
            $('questionvoite_down_' + obj_id).set('html', '<span class="qa_unlike_btn"></span>').set('title', voted_text);
            var d_class = this.checkClass('down', voite);
            $('questionvoite_down_' + obj_id).addClass(d_class);
            $('questionvoite_likes_' + obj_id).set('text', en4.core.language.translate("Score") + ' ' + response.sum);
            new Tips($('questionvoite_' + obj_id).getElements('.Tips'));
        }.bind(this));
    },
    subscribertoggle: function() {
        this.run_JSON('subscribertoggle',
                {'question_id': this.options.question_id},
        function(response) {
            var toggle = $('question_subscribe_toggle');
            toggle.set('text', response.result_text);
            /*toggle.toggleClass('subscribe_icon').toggleClass('unsubscribe_icon');*/
        }.bind(this));
    },
    checkClass: function(d, voite) {
        var new_class = 'Tips';
        if ((voite === '+' && d === 'up') || (voite === '-' && d === 'down'))
            new_class += ' voted';
        return new_class;
    }

});

/**
 * Comments
 */
question.comments = {
    loadComments: function(type, id, page) {
        en4.core.request.send(new Request.HTML({
            url: en4.core.baseUrl + 'question/comment/list',
            data: {
                format: 'html',
                type: type,
                id: id,
                page: page
            }
        }), {
            'element': $('comments_' + id)
        });
    },
    attachCreateComment: function(formElement) {
        var bind = this;
        formElement.addEvent('submit', function(event) {
            event.stop();
            $('question_subscribe_toggle').set('text', en4.core.language.translate("Unsubscribe"));
            var form_values = formElement.toQueryString();
            form_values += '&format=json';
            form_values += '&id=' + formElement.identity.value;
            en4.core.request.send(new Request.JSON({
                url: en4.core.baseUrl + 'question/comment/create',
                data: form_values
            }), {
                'element': $('comments_' + formElement.identity.value)
            });
        })
    },
    comment: function(type, id, body) {
        en4.core.request.send(new Request.JSON({
            url: en4.core.baseUrl + 'question/comment/create',
            data: {
                format: 'json',
                type: type,
                id: id,
                body: body
            }
        }), {
            'element': $('comments_' + id)
        });
    },
    deleteComment: function(type, id, comment_id) {
        if (!confirm(en4.core.language.translate('Are you sure you want to delete this?'))) {
            return;
        }
        (new Request.JSON({
            url: en4.core.baseUrl + 'question/comment/delete',
            data: {
                format: 'json',
                type: type,
                id: id,
                comment_id: comment_id
            },
            onComplete: function() {
                if ($('comment-' + comment_id)) {
                    $('comment-' + comment_id).destroy();
                }
                try {
                    var commentCount = $('count_comments_' + id);
                    var m = commentCount.get('html').match(/\d+/);
                    var newCount = (parseInt(m[0]) != 'NaN' && parseInt(m[0]) > 1 ? parseInt(m[0]) - 1 : 0);
                    commentCount.set('html', commentCount.get('html').replace(m[0], newCount));
                } catch (e) {
                }
            }
        })).send();
    }
};

var question_moderation = new Class({
    Extends: question_basic,
    comment_move_answers: function(comment_id) {
        this.run_JSON('comment-move-answers',
                {
                    'question_id': this.options.question_id,
                    'comment_id': comment_id
                },
        function(response) {
            window.location.href = window.location.href;
        }.bind(this));
    },
    comment_move_comments: function(comment_id, answer_id) {
        this.reset_selected();
        this.show_select_button(answer_id, comment_id, 'do_comment_move_comments');
        $('comment-' + comment_id).addClass('select_item');
    },
    answer_move_comments: function(answer_id) {
        this.reset_selected();
        this.show_select_button(answer_id, answer_id, 'do_answer_move_comments');
        $('answer-' + answer_id).addClass('select_item');
    },
    show_select_button: function(main_answer_id, resource_id, run_function) {
        $('reset_selected').removeClass('select_hide');
        $('qa_browse').getElements("[id^='answer_hide_button-']").each(function(item, index) {
            if (item.get('id') != 'answer_hide_button-' + main_answer_id) {
                item.removeClass('select_hide');
                item.addEvent('click', function() {
                    this[run_function](resource_id, item.get('id').match(/\d+/)[0])
                }.bind(this));
            }
        }.bind(this));
    },
    reset_selected: function() {
        $('reset_selected').addClass('select_hide');
        $('qa_browse').getElements('li.select_item').removeClass('select_item');
        $('qa_browse').getElements("[id^='answer_hide_button-']").each(function(item, index) {
            if (!item.hasClass('select_hide')) {
                item.addClass('select_hide').removeEvents();
            }
            item.removeEvents();
        });
    },
    do_comment_move_comments: function(comment_id, destination_answer_id) {
        this.run_JSON('comment-move-comments',
                {
                    'question_id': this.options.question_id,
                    'comment_id': comment_id,
                    'destination_answer_id': destination_answer_id
                },
        function(response) {
            window.location.href = window.location.href;
        }.bind(this));
    },
    do_answer_move_comments: function(answer_id, destination_answer_id) {
        this.run_JSON('answer-move-comments',
                {
                    'question_id': this.options.question_id,
                    'answer_id': answer_id,
                    'destination_answer_id': destination_answer_id
                },
        function(response) {
            window.location.href = window.location.href;
        }.bind(this));
    }
});

question.subject = new Class({
    Extends: question_basic,
    options: {
        module: 'core',
        controller: 'widget',
        action: 'index',
        content_id: null
    },
    initialize: function(options) {
        this.parent(options);
    },
    getURL: function(action) {
        return en4.core.baseUrl + this.options.module + '/' + this.options.controller + '/' + this.options.action + '/content_id/' + this.options.content_id + '/view/' + action;
    },
    getContent: function(action, params) {
        try {
            var anchor = $$('div.tab_' + this.options.content_id).getLast();
        } catch (e) {
            return;
        }
        var send_data = {
            format: 'html',
            subject: en4.core.subject.guid,
            container: 0
        }
        if (typeof(params) == 'object') {
            send_data = $extend(params, send_data);
        }
        en4.core.request.send(new Request.HTML({
            url: this.getURL(action),
            data: send_data
        }),
        {
            updateHtmlElement: anchor

        });
    }
});
