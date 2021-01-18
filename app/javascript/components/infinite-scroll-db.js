/* eslint-disable no-undef */
const infiniteScroll = () => {
  if (document.querySelector('.container-database')) {
    const THRESHOLD = 30;
    const windowScreen = $(window);
    const documentScreen = $(document);
    let paginationElem = $('.container-pagination');
    const paginationUrl = paginationElem.attr('data-pagination-endpoint');
    const pagesAmount = paginationElem.attr('data-pagination-pages');
    let currentPage = 1;
    let baseEndpoint;

    // validates if pagination URL has query params
    if (paginationUrl.endsWith('?')) {
      baseEndpoint = `${paginationUrl}&page=`;
    } else {
      baseEndpoint = `${paginationUrl}?page=`;
    }

    // Initialize pagination
    paginationElem.hide();
    let isPaginating = false;

    const clearResult = () => {
      setTimeout(() => {
        clearTimeout();
        paginationElem.hide();
      }, 100);
    };

    const appendResult = (resultat) => {
      setTimeout(() => {
        $('.flex-database').append(resultat);
        isPaginating = false;
        clearResult();
      }, 1000);
    };
    const handleDisplaying = () => {
      paginationElem = $('.container-pagination');
      const numberElements = paginationElem.attr('data-number');
      if (numberElements < 25) {
        paginationElem.hide();
      }
      const dbVide = $('.container-db-vide')[0];
      if (numberElements === 0) {
        dbVide.style.display = '';
      } else {
        dbVide.style.display = 'none';
      }
    };

    // Call the function when click on the search button or database btn
    document.getElementById('btn-database').addEventListener('click', () => {
      setTimeout(handleDisplaying, 200);
    });
    document.getElementById('btn-search').addEventListener('click', () => {
      setTimeout(handleDisplaying, 200);
    });

    // Listen to scrolling
    windowScreen.on('scroll', async () => {
      // Handle the search, in this case we reset the variable - CurrentPage - to 1
      const paginationElem = $('.container-pagination');
      if (paginationElem.attr('data-search') === 'result') {
        currentPage = 1;
        paginationElem.attr('data-search', 'scroll');
      }
      if (currentPage >= pagesAmount) {
        setTimeout(() => {
          paginationElem.hide();
        }, 1000);
      }
      if (
        !isPaginating &&
        currentPage < pagesAmount &&
        windowScreen.scrollTop() >
          documentScreen.height() - windowScreen.height() - THRESHOLD
      ) {
        isPaginating = true;
        currentPage += 1;
        paginationElem.show();
        $.ajax({
          url: baseEndpoint + currentPage,
        }).then((resultat) => {
          if (window.location.href.endsWith(baseEndpoint.split('/')[1])) {
            appendResult(resultat);
          }
        })
      }
    });
  }
};

export { infiniteScroll };
