const cardForm = () => {
  if ($('.card-form')) {
    $('.card-form').click((event) => {
      event.currentTarget.classList.toggle('active');
    });
  }
};

export { cardForm };
