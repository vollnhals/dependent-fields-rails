Dependent Fields for Rails
===========

DependentFields makes it easy to hide or show dependent fields in forms based on select or checkbox values.


Installation
------------

1. Add `gem 'dependent-fields-rails'` to your Gemfile.
1. Run `bundle install`.
1. Add `//= require dependent-fields` to your Javascript manifest file (usually found at `app/assets/javascripts/application.js`).
1. Bind events, for example with jquery:

        $(document).ready(function() {
            DependentFields.bind()
        }

1. Restart your server and everything should be set up. See Usage below on how to declare your dependent fields in views.


Dependencies
------------

Be sure to include underscorejs and jquery in your page.


Usage
-------

Dependent Fields may depend on select or checkbox input elements. You have to surround your dependent fields with
a `div` with class `js-dependent-fields`.

The examples below are written in the slim template language with simple_form. But you can use dependent-fields with every other template language out there.


### Depending on a select element

Note the data attributes on the js-dependent-fields div.

    = simple_form_for(@filing) do
        = f.input :registration_office, collection: ['habm', 'dpma']

        .js-dependent-fields[data-select-id='filing_registration_office' data-option-value='habm']
            = f.input :language, collection: ['english', 'german']

The language selector will only be shown if the user selects 'habm' in the registration office.

You can also specify multiple option values by seperating them with `|`. For example: `data-option-value='habm|dpma'`


### Depending on a checkbox input element

Note the data attributes on the js-dependent-fields div.

    = simple_form_for(@filing) do
        = f.input :priority_enabled

        .js-dependent-fields[data-checkbox-id='filing_priority_enabled' data-checkbox-value='true']
          = f.input :priority_date
          = f.input :priority_filing_nr

The date and filing_nr fields will only be shown if the user checks the priority_enabled field.


### Depending on a radio input element

Relevant radio inputs are selected by name and not by id, because radio inputs in the same group have different ids but the same name.
Note the data attributes on the js-dependent-fields div.

    = simple_form_for(@filing) do
        = f.input :registration_office, collection: ['habm', 'dpma'], as: :radio_buttons

        .js-dependent-fields[data-radio-name='filing[registration_office]' data-radio-value='habm']
            = f.input :language, collection: ['english', 'german']

The language selector will only be shown if the user selects 'habm' in the registration office.

You can also specify multiple option values by seperating them with `|`. For example: `data-radio-value='habm|dpma'`


### Disabling instead of hiding fields

Add `data-method='disable'` to the js-dependent-fields div.



Minimal Demo
------------

http://jsfiddle.net/mwhSt/


Changelog
---------

### 0.4.2

make it compatible with rails4. thanks to mcbridejc for the pull request.

### 0.4.1

fix escaping of attribute names. thanks to nagyt234 for the pull request.
