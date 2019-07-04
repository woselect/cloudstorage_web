$(document).ready(function($,_) {
        var saveNewCourse = function (e) {
            // One final check for empty values
            var errors = _.reduce(
                ['.new-course-name', '.new-course-org', '.new-course-number', '.new-course-run'],
                function (acc, ele) {
                    var $ele = $(ele);
                    var error = validateRequiredField($ele.val());
                    setNewCourseFieldInErr($ele.parent('li'), error);
                    return error ? true : acc;
                },
                false
            );

            if (errors) {
                return;
            }
            var $newCourseForm = $(this).closest('#create-course-form');
            var display_name = $newCourseForm.find('.new-course-name').val();
            var org = $newCourseForm.find('.new-course-org').val();
            var number = $newCourseForm.find('.new-course-number').val();
            var run = $newCourseForm.find('.new-course-run').val();

            analytics.track('Created a Course', {
                'org': org,
                'number': number,
                'display_name': display_name,
                'run': run
            });

            $.postJSON('/course/', {
                    'org': org,
                    'number': number,
                    'display_name': display_name,
                    'run': run
                },
                function (data) {
                    if (data.url !== undefined) {
                        window.location = data.url;
                    } else if (data.ErrMsg !== undefined) {
                        $('.wrap-error').addClass('is-shown');
                        $('#course_creation_error').html('<p>' + data.ErrMsg + '</p>');
                        $('.new-course-save').addClass('is-disabled');
                    }
                }
            );
        };

        var cancelNewCourse = function (e) {
            $('.new-course-button').removeClass('is-disabled');
            $('.wrapper-create-course').removeClass('is-shown');
            // Clear out existing fields and errors
            _.each(
                ['.new-course-name', '.new-course-org', '.new-course-number', '.new-course-run'],
                function (field) {
                    $(field).val('');
                }
            );
            $('#course_creation_error').html('');
            $('.wrap-error').removeClass('is-shown');
            $('.new-course-save').off('click');
        };

        var addNewCourse = function (e) {
           
            $('.new-course-button').addClass('is-disabled');
            //$('.new-course-save').addClass('is-disabled');
            var $newCourse = $('.wrapper-create-course').addClass('is-shown');
            var $cancelButton = $newCourse.find('.new-course-cancel');
            var $courseName = $('.new-course-name');
            $courseName.focus().select();
            $('.new-course-save').on('click', saveNewCourse);
            $cancelButton.bind('click', cancelNewCourse);
            //CancelOnEscape($cancelButton);

            // Check that a course (org, number, run) doesn't use any special characters
            var validateCourseItemEncoding = function (item) {
                var required = validateRequiredField(item);
                if (required) {
                    return required;
                }
                if ($('.allow-unicode-course-id').val() === 'True'){
                    if (/\s/g.test(item)) {
                        return gettext('Please do not use any spaces in this field.');
                    }
                }
                else{
                   if (item !== encodeURIComponent(item)) {
                       return gettext('Please do not use any spaces or special characters in this field.');
                   }
                }
                return '';
            };

            // Ensure that org/course_num/run < 65 chars.
            var validateTotalCourseItemsLength = function () {
                var totalLength = _.reduce(
                    ['.new-course-org', '.new-course-number', '.new-course-run'],
                    function (sum, ele) {
                        return sum + $(ele).val().length;
                    }, 0
                );
                if (totalLength > 65) {
                    $('.wrap-error').addClass('is-shown');
                    $('#course_creation_error').html('<p>' + gettext('The combined length of the organization, course number, and course run fields cannot be more than 65 characters.') + '</p>');
                    $('.new-course-save').addClass('is-disabled');
                }
                else {
                    $('.wrap-error').removeClass('is-shown');
                }
            };

            // Handle validation asynchronously
            _.each(
                ['.new-course-org', '.new-course-number', '.new-course-run'],
                function (ele) {
                    var $ele = $(ele);
                    $ele.on('keyup', function (event) {
                        // Don't bother showing "required field" error when
                        // the user tabs into a new field; this is distracting
                        // and unnecessary
                        if (event.keyCode === 9) {
                            return;
                        }
                        var error = validateCourseItemEncoding($ele.val());
                        setNewCourseFieldInErr($ele.parent('li'), error);
                        validateTotalCourseItemsLength();
                    });
                }
            );
            var $name = $('.new-course-name');
            $name.on('keyup', function () {
                var error = validateRequiredField($name.val());
                setNewCourseFieldInErr($name.parent('li'), error);
                validateTotalCourseItemsLength();
            });
        };

        var validateRequiredField = function (msg) {
            return msg.length === 0 ? gettext('Required field.') : '';
        };

        var setNewCourseFieldInErr = function (el, msg) {
            if(msg) {
                el.addClass('error');
                el.children('span.tip-error').addClass('is-showing').removeClass('is-hiding').text(msg);
                $('.new-course-save').addClass('is-disabled');
            }
            else {
                el.removeClass('error');
                el.children('span.tip-error').addClass('is-hiding').removeClass('is-showing');
                // One "error" div is always present, but hidden or shown
                if($('.error').length === 1) {
                    $('.new-course-save').removeClass('is-disabled');
                }
            }
        };

        
        $('body').click(function(e) {
            $('.nav-dd .nav-item .wrapper-nav-sub').removeClass('is-shown');
            $('.nav-dd .nav-item .title').removeClass('is-selected');
        });

        $('.nav-dd .nav-item').click(function(e) {

            $subnav = $(this).find('.wrapper-nav-sub');
            $title = $(this).find('.title');

            if ($subnav.hasClass('is-shown')) {
                $subnav.removeClass('is-shown');
                $title.removeClass('is-selected');
            } else {
                $('.nav-dd .nav-item .title').removeClass('is-selected');
                $('.nav-dd .nav-item .wrapper-nav-sub').removeClass('is-shown');
                $title.addClass('is-selected');
                $subnav.addClass('is-shown');
                // if propagation is not stopped, the event will bubble up to the
                // body element, which will close the dropdown.
                e.stopPropagation();
            }
        });
        
       /*$('.new-component-type').click(function(e) {
    	   $('.new-component').slideUp(250);
           $('.new-component-templates').slideDown(250);
       });
       
       $('.cancel-button').click(function(e) {
    	   $('.new-component').slideDown(250);
           $('.new-component-templates').slideUp(250);
       });
       */
       $('.new-course-button').bind('click', addNewCourse);
             
});
