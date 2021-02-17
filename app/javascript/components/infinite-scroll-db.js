/* eslint-disable no-undef */
const infiniteScroll = () => {
  if (document.querySelector('.container-database')) {
    const THRESHOLD = 200;
    const windowScreen = $(window);
    const documentScreen = $(document);
    let paginationElem = $('.container-pagination');
    const paginationUrl = paginationElem.attr('data-pagination-endpoint');
    const pagesAmount = paginationElem.attr('data-pagination-pages');
    let currentPage = 1;

    // Initialize pagination
    paginationElem.hide();
    let isPaginating = false;

    const clearResult = () => {
      clearTimeout();
      paginationElem.hide();
    };

    const appendResult = (resultat) => {
      $('.flex-database').append(resultat);
      isPaginating = false;
      clearResult();
    };

    const handleDisplaying = () => {
      paginationElem = $('.container-pagination');
      const numberElements = parseInt(paginationElem.attr('data-number'), 10);
      if (numberElements < 50) {
        paginationElem.hide();
      }
      const dbVide = $('.container-db-vide')[0];
      if (numberElements === 0) {
        dbVide.style.display = '';
      } else if ((numberElements) ) {
        dbVide.style.display = 'none';
      }
    };
    
    // Call the function when click on the search button or database btn
    document.getElementById('btn-database').addEventListener('click', () => {
      document.getElementById('query').value = '';
      setTimeout(handleDisplaying, 200);
    });
    document.getElementById('btn-search').addEventListener('click', () => {
      setTimeout(handleDisplaying, 200);
    });

    // Listen to scrolling
    windowScreen.on('scroll', () => {
      // Handle the search, in this case we reset the variable - CurrentPage - to 1
      const paginationElemt = $('.container-pagination');
      if (paginationElemt.attr('data-search') === 'search') {
        currentPage = 1;
        paginationElemt.attr('data-search', 'scroll');
      }
      if (currentPage >= pagesAmount) {
        paginationElemt.hide();
      }
      if (
        !isPaginating &&
        currentPage < pagesAmount &&
        windowScreen.scrollTop() >=
          documentScreen.height() - windowScreen.height() - THRESHOLD
      ) {
        isPaginating = true;
        currentPage += 1;
        const query = document.getElementById('query').value;
        paginationElemt.show();
        $.ajax({
          url: `${paginationUrl}?page=${currentPage}&query=${query}`,
        }).then((resultat) => {
          // Verify that we are on the good page
          if (window.location.href.endsWith(paginationUrl.split('/')[1])) {
            appendResult(resultat);
          }
        });
      }
    });
  }
};

export default infiniteScroll;
