const infiniteScroll = () => {
  if(document.querySelector('.container-database')){
    const THRESHOLD = 30;
    const window_screen = $(window);
    const document_screen = $(document);
    let paginationElem = $('.container-pagination');
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
      // Handle the search, in this case we reset the variable - CurrentPage - to 1
      let paginationElem = $('.container-pagination');
      if (paginationElem.attr('data-search') == "result") {
        currentPage = 1;
        paginationElem.attr('data-search', 'scroll');
      };
      if(currentPage >= pagesAmount) {
        setTimeout(function(){
          paginationElem.hide();
        }, 1000);
      };
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