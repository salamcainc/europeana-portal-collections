module MustacheHelper
  def head_meta
    [
      #{'name':'X-UA-Compatible',    content: 'IE=edge' },
      #{'name':'viewport',           content: 'width=device-width,initial-scale=1.0' },
      { meta_name: 'HandheldFriendly',   content: 'True' },
      { httpequiv: 'Content-Type',       content: 'text/html; charset=utf-8' },
      { meta_name: 'csrf-param',         content: 'authenticity_token' },
      { meta_name: 'csrf-token',         content: form_authenticity_token }
    ]
  end

  def page_title
    if @response.nil?
      'Europeana Channels'
    elsif @response['action'].to_s == 'search.json'
      'Europeana Search' + search_page_title
    elsif params[:action].to_s == 'show'
      if @document.is_a?(Blacklight::Document)
        rec = @document.fetch(:title, ['']).join(', ')
        'Europeana Record' + (rec.present? ? ': ' + rec : rec)
      end
    end
  end

  def form_search
    {
      action: search_action_path(only_path: true)
    }
  end

  def head_links
    [
      { rel: 'search',         type: 'application/opensearchdescription+xml', href: request.host_with_port + '/catalog/opensearch.xml', title: 'Blacklight' },
      { rel: 'shortcut icon',  type: 'image/x-icon',                          href: asset_path('favicon.ico') },
#      { rel: 'stylesheet',     href: asset_path('blacklight.css'),            media: 'all' },
      { rel: 'stylesheet',     href: asset_path('europeana.css'),             media: 'all' }
    ]
  end

  # model for the search form
  def input_search
    {
      title: 'Search',
      input_name: 'q[]',
      empty: params[:q].blank?,
      input_values: input_search_values(params[:q]),
      placeholder: 'Add a search term'
    }
  end

  # model for the search form
  def input_search
    {
      title: t('global.search-area.search-button-image-alt'),
      input_name: params[:q].blank? ? 'q' : 'qf[]',
      has_original: !params[:q].blank?,
      input_original: {
        value:  params[:q].blank? ? nil : params[:q],
        remove: params[:qf].blank? ? search_action_path : search_action_path + '?q=' + params[:qf].join('&qf[]=')
      },
      input_values: input_search_values(params[:qf]),
      placeholder: t('site.search.placeholder.text')
    }
  end

  
  def image_root
    'http://develop.styleguide.eanadev.org/images/'
  end

  def js_variables
    'var js_path= "http://develop.styleguide.eanadev.org/js/dist/";'
    #'var js_path= "http://localhost/Europeana-Patternlab/public/js/dist/";'
  end
  
  def js_files
    [
      { path: asset_path('jquery.js') },
     
      { path: 'http://develop.styleguide.eanadev.org/js/dist/global.js' },
      { path: 'http://develop.styleguide.eanadev.org/js/dist/channels.js' },
        
      #{ path: 'http://localhost/x/Europeana-Patternlab/public/js/dist/channels.js' },
      #{ path: 'http://localhost/x/Europeana-Patternlab/public/js/dist/global.js' },
        
      # Blacklight dependencies
      #{ path: asset_path('turbolinks.js') },
      #{ path: asset_path('blacklight/core.js') },
      #{ path: asset_path('blacklight/autofocus.js') },
      #{ path: asset_path('blacklight/checkbox_submit.js') },
      #{ path: asset_path('blacklight/bookmark_toggle.js') },
      #{ path: asset_path('blacklight/ajax_modal.js') },
      { path: asset_path('blacklight/search_context.js') }
      #{ path: asset_path('blacklight/collapsable.js') },
      #{ path: asset_path('bootstrap/transition.js') },
      #{ path: asset_path('bootstrap/collapse.js') },
      #{ path: asset_path('bootstrap/dropdown.js') },
      #{ path: asset_path('bootstrap/alert.js') },
      #{ path: asset_path('bootstrap/modal.js') },
      #{ path: asset_path('blacklight/blacklight.js') }
    ]
  end

  def menus
    {
      actions: {
        button_title: 'Actions',
        menu_id: 'dropdown-result-actions',
        menu_title: 'Save to:',
        items: [
          {
            url: 'http://europeana.eu',
            text: 'First Item'
          },
          {
            url: 'http://europeana.eu',
            text: 'Another Label'
          },
          {
            url: 'http://europeana.eu',
            text: 'Label here'
          },
          {
            url: 'http://europeana.eu',
            text: 'Fourth Item'
          },
          {
            divider: true
          },
          {
            url: 'http://europeana.eu',
            text: 'Another Label',
            calltoaction: true
          },
          {
            divider: true
          },
          {
            url: 'http://europeana.eu',
            text: 'Another Label',
            calltoaction: true
          }
        ]
      },
      sort: {
        button_title: 'Relevance',
        menu_id: 'dropdown-result-sort',
        menu_title: 'Sort by:',
        items: [
          {
            text: 'Date',
            url: 'http://europeana.eu'
          },
          {
            text: 'Alphabetical',
            url: 'http://europeana.eu'
          },
          {
            text: 'Relevance',
            url: 'http://europeana.eu'
          },
          {
            divider: true
          },
          {
            url: 'http://europeana.eu',
            text: 'Another Label',
            calltoaction: true
          },
          {
            divider: true
          },
          {
            text: 'Advanced Search',
            url: 'http://europeana.eu',
            calltoaction: true
          }
        ]
      }
    }
  end

  def total_item_count
    @europeana_item_count ? number_with_delimiter(@europeana_item_count) : nil
  end
  
  def channels_nav_links
    available_channels.collect do |c|
      {
        url: channel_path(c),
        text: c
      }
    end
  end

  def page_config
    {
      :newsletter  => true
    }
  end

  def search_page_title
    return '' if params[:q].nil?

    ': ' + [params[:q]].flatten.join(', ')
  end

  
  def navigation_global
  {
      :options => {
        :search_active  => false,
        :settings_active  => true
      },
        
      :logo  => {
        :url  => "/",
        :text  => "Europeana Search"
      },
      
      :primary_nav  => {
        :items  => [
          {
            :url  => "#",
            :text  => "Home",
            :is_current  => true
          },
          {
            :url  => "",
            :text  => "Channels",
            :submenu  => {
              :items  => [
                {
                  :url  => "http://google.com",
                  :text  => "Channel 1"
                },
                {
                  :url  => "http://google.com",
                  :text  => "Channel 2",
                  :is_current  => true
                },
                {
                  :url  => "http://google.com",
                  :text  => "Channel 3"
                }
              ]
            }
          },
          {
            :url   =>  "",
            :text  =>  "Exhibitions"
          },
          {
            :url   => "",
            :text  => "Blog"
          },
          {
            :url   => "",
            :text  => "My Europeana"
          }
        ]
    },
  
    :footer  => common_footer
  }
  end

  def common_footer
    {
      :linklist1  => {
        :title  => "More info",
        :items  =>  [
          {
            :text  => "New collections",
            :url   => "http://google.com"
          },
          {
            :text => "All data providers",
            :url  => "http://google.com"
          },
          {
            :text =>  "Become a data provider",
            :url  => "http://google.com"
          }
        ]
      },
      :linklist2 => {
        :title  =>  "Help",
        :items  =>  [
          {
            :text => "Search tips",
            :url  => "http://google.com"
          },
          {
            :text =>  "Using My Europeana",
            :url  => "http://google.com"
          },
          {
            :text  => "Copyright",
            :url   => "http://google.com"
          }
        ]
      },
      :social  => {
        :facebook   => true,
        :pinterest  => true,
        :twitter    => true,
        :googleplus => true
      }
    }    
  end
  
  # @param qs [Array] q params
  # @return [Array<Hash>]
  def input_search_values(qs)
    return [] if qs.nil?
    [qs].flatten.reject(&:blank?).collect do |q|
      {
        value: q,
        remove: search_action_path(remove_qf_param(q, params))
      }
    end
  end

  def news_items
    @blog_items[0..2].collect do |item|
      {
        headline: {
          medium: CGI.unescapeHTML(item.title)
        },
        url: CGI.unescapeHTML(item.url),
        img: {
          rectangle: {
            src: nil,
            alt: nil
          }
        },
        excerpt: {
          short: CGI.unescapeHTML(item.summary)
        }
      }
    end
  end
end
