defined?(Footnotes) && Footnotes.setup do |f|
  # Wether or not to enable footnotes
  f.enabled = Rails.env.development?
  
  

  # You can also use a lambda / proc to conditionally toggle footnotes
  # Example :
  # f.enabled = -> { User.current.admin? }
  # Beware of thread-safety though, Footnotes.enabled is NOT thread safe
  # and should not be modified anywhere else.
  f.enabled = true
  # Only toggle some notes :
  f.notes = [:assigns, :session, :cookies, :params, :filters, :routes, :env, :queries, :log]
  f.notes += [:page_load]
  # Change the prefix :
  # f.prefix = 'txmt://open?url=file://%s&line=%d&column=%d'

  # Disable style :
  # f.no_style = true

  # Lock notes to top right :
  # f.lock_top_right = true

  # Change font size :
  # f.font_size = '11px'

  # Allow to open multiple notes :
  # f.multiple_notes = true
end
