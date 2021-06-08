Grover.configure do |config|
  config.use_png_middleware = true
  config.options = {
    viewport: {
      width: 1024,
      height: 768
    },
    prefer_css_page_size: true,
    emulate_media: 'screen',
    cache: true,
    timeout: 0,
    wait_for_timeout: 1000,
    full_page: true,
    print_background: true,
  }
end