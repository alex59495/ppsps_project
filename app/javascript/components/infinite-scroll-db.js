const infiniteScroll = () => {
  if(document.querySelector('.container-database')){
    const THRESHOLD = 30;
    const paginationElem = $('.container-pagination');
    const window_screen = $(window);
    const document_screen = $(document);
    const paginationUrl = paginationElem.attr('data-pagination-endpoint');
    const pagesAmount = paginationElem.attr('data-pagination-pages');
    let currentPage = 1;
    let baseEndpoint;
  
    // validates if pagination URL has query params
    if(paginationUrl.indexOf('?') != -1) {
      baseEndpoint = paginationUrl + "&page="
    } else {
      baseEndpoint = paginationUrl + "?page="
    }
  
    // Initialize pagination
    paginationElem.hide()
    let isPaginating = false
  
    const appendResult = (resultat) => {
      setTimeout(function(){
        $('.flex-database').append(resultat);
        isPaginating = false;
        clearResult()
      }, 1000)
    }

    const clearResult = () => {
      setTimeout(function(){
        clearTimeout();
        paginationElem.hide();
      }, 100)
    };
  
    // Listen to scrolling
    window_screen.on('scroll', () => {
      if(!isPaginating && currentPage < pagesAmount && window_screen.scrollTop() > document_screen.height() - window_screen.height() - THRESHOLD) {
        isPaginating = true;
        currentPage++;
        paginationElem.show();
        $.ajax({
          url: baseEndpoint + currentPage
        }).then(resultat => {
          appendResult(resultat)
        });
      };
    });
  }
}

export { infiniteScroll}