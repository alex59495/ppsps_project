/* eslint-disable prefer-destructuring */
const calendar = () : void => {
  const startInput : HTMLInputElement = document.querySelector('#range_start');
  const startDayCalendar : HTMLElement = document.getElementById('start-day-calendar');
  const startMonthCalendar : HTMLElement = document.getElementById('start-month-calendar');
  const startYearCalendar : HTMLElement = document.getElementById('start-year-calendar');
  const endDayCalendar : HTMLElement = document.getElementById('end-day-calendar');
  const endMonthCalendar : HTMLElement = document.getElementById('end-month-calendar');
  const endYearCalendar : HTMLElement = document.getElementById('end-year-calendar');
  const endInput : HTMLInputElement = document.querySelector('#range_end');

  const changeDate = () : void => {
    const dateStart : Date = new Date(startInput.value);
    if (!Number.isNaN(dateStart.getTime())) {
      startMonthCalendar.firstChild.textContent = dateStart
        .toString()
        .split(' ')[1];
      startDayCalendar.innerText = dateStart.toString().split(' ')[2];
      startYearCalendar.innerText = dateStart.toString().split(' ')[3];
    }
    const dateEnd : Date = new Date(endInput.value);
    if (!Number.isNaN(dateEnd.getTime())) {
      endMonthCalendar.firstChild.textContent = dateEnd
        .toString()
        .split(' ')[1];
      endDayCalendar.innerText = dateEnd.toString().split(' ')[2];
      endYearCalendar.innerText = dateEnd.toString().split(' ')[3];
    }
  };

  const calendarBox : HTMLElement = document.querySelector('.calendar-box');
  if (calendarBox) {
    startInput.addEventListener('change', () => {
      changeDate();
    });
  }
};

export default calendar;
