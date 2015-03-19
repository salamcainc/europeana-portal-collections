module MustacheHelper
  def pagetitle
    params['q']
  end

  def searchresults
    @document_list
  end

  def head_meta
    [
      #{'name':'X-UA-Compatible',    'content': 'IE=edge'},
      #{'name':'viewport',           'content': 'width=device-width,initial-scale=1.0'},
      {'meta_name':'HandheldFriendly',   'content': 'True'},
      {'httpequiv':'Content-Type',       'content': 'text/html; charset=utf-8' },
      {'meta_name':'csrf-param',         'content': 'authenticity_token'},
      {'meta_name':'csrf-token',         'content': form_authenticity_token }
    ]
  end

  def form_action_search
    request.protocol + request.host_with_port + '/'
  end

  def head_links
    [
      { 'rel': 'search',         'type': 'application/opensearchdescription+xml', 'href': request.host_with_port + '/catalog/opensearch.xml', 'title': 'Blacklight' },
      { 'rel': 'shortcut icon',  'type': 'image/x-icon',                          'href': asset_path('favicon.ico') },
      { 'rel': 'stylesheet',     'href': asset_path('blacklight.css'),            'media': 'all' },
      { 'rel': 'stylesheet',     'href': asset_path('europeana.css'),             'media': 'all' },
      { 'rel': 'stylesheet',     'href': asset_path('application.css'),           'media': 'all' }
    ]
  end

  def input_search
    {
      'title': 'Search',
      'input_name':  'q',
      'input_value': params['q'] ? params['q'] : '',
      'placeholder': 'Add a search term'
    }
  end

  def js_files
    # All theses are blacklight's dependencies - getting the via the helper would be nicer
    [
      {'path': asset_path('jquery.js')},
      {'path': asset_path('turbolinks.js')},
      {'path': asset_path('blacklight/core.js')},
      {'path': asset_path('blacklight/autofocus.js')},
      {'path': asset_path('blacklight/checkbox_submit.js')},
      {'path': asset_path('blacklight/bookmark_toggle.js')},
      {'path': asset_path('blacklight/ajax_modal.js')},
      {'path': asset_path('blacklight/search_context.js')},
      {'path': asset_path('blacklight/collapsable.js')},

      {'path': asset_path('bootstrap/transition.js')},
      {'path': asset_path('bootstrap/collapse.js')},
      {'path': asset_path('bootstrap/dropdown.js')},
      {'path': asset_path('bootstrap/alert.js')},
      {'path': asset_path('bootstrap/modal.js')},

      {'path': asset_path('blacklight/blacklight.js')}
    ]
  end

  def menus
    {
      'actions': {
        'button-title':'Actions',
        'menu_id': 'dropdown-result-actions',
        'menu-title': 'Save to:',
        'items': [
          {
            'url':'http://europeana.eu',
            'text': 'First Item'
          },
          {
            'url':'http://europeana.eu',
            'text': 'Another Label'
          },
          {
            'url':'http://europeana.eu',
            'text': 'Label here'
          },
          {
            'url':'http://europeana.eu',
            'text': 'Fourth Item'
          },
          {
            'divider': true
          },
          {
            'url':'http://europeana.eu',
            'text': 'Another Label',
            'calltoaction': true
          },
          {
            'divider': true
          },
          {
            'url':'http://europeana.eu',
            'text': 'Another Label',
            'calltoaction': true
          }
        ]
      },
      'sort': {
        'button-title':'Relevance',
        'menu_id': 'dropdown-result-sort',
        'menu-title': 'Sort by:',
        'items': [
          {
            'text': 'Date',
            'url':'http://europeana.eu'
          },
          {
            'text': 'Alphabetical',
            'url':'http://europeana.eu'
          },
          {
            'text': 'Relevance',
            'url':'http://europeana.eu'
          },
          {
            'divider': true
          },
          {
            'url':'http://europeana.eu',
            'text': 'Another Label',
            'calltoaction': true
          },
          {
            'divider': true
          },
          {
            'text': 'Advanced Search',
            'url':'http://europeana.eu',
            'calltoaction': true
          }
        ]
      }
    }
  end
end
