module EuropeanaBlacklightAdapter
  extend ActiveSupport::Concern
  
  def blacklight_solr
    @europeana_api ||= RSolr::Europeana.connect(blacklight_solr_config.merge(api_key: Rails.application.secrets.europeana_api_key))
  end
  
  def solr_doc_params(id = nil)
    id ||= [ params[:provider_id], params[:record_id] ].join('/')
    super(id)
  end
  
  def channels_search_params
    if @channels_search_params.nil?
      @channels_search_params = {}
      if current_search_session.query_params[:controller] == 'channels'
        if current_search_session.query_params[:id]
          channel = Channel.find(current_search_session.query_params[:id].to_sym)
          query_parts = []
          query_parts << "(#{channel.query})" if channel.query.present?
          query_parts << "(#{current_search_session.query_params[:q]})" if current_search_session.query_params[:q].present?
          @channels_search_params[:q] = query_parts.join(' AND ')
        end
      end
    end
    @channels_search_params
  end
  
  # Identical to Blacklight::Catalog::SearchContext#setup_next_and_previous_documents
  # but with addition of channels_search_params to get_previous_and_next_documents_for_search
  # method call.
  def setup_next_and_previous_documents
    if search_session['counter'] and current_search_session
      index = search_session['counter'].to_i - 1
      response, documents = get_previous_and_next_documents_for_search index, current_search_session.query_params.with_indifferent_access, channels_search_params

      search_session['total'] = response.total
      @search_context_response = response
      @previous_document = documents.first
      @next_document = documents.last
    end
  end
end
