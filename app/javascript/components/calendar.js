/* eslint-disable prefer-destructuring */
const calendar = () => {
  const startInput = document.querySelector('#range_start');
  const startDayCalendar = document.getElementById('start-day-calendar');
  const startMonthCalendar = document.getElementById('start-month-calendar');
  const endDayCalendar = document.getElementById('end-day-calendar');
  const endMonthCalendar = document.getElementById('end-month-calendar');

  const changeDate = () => {
    const endInput = document.querySelector('#range_end');
    const dateStart = new Date(startInput.value);
    if (!Number.isNaN(dateStart.getTime())) {
      startMonthCalendar.firstChild.innerText = dateStart
        .toString()
        .split(' ')[1];
      startDayCalendar.innerText = dateStart.toString().split(' ')[2];
    }
    const dateEnd = new Date(endInput.value);
    if (!Number.isNaN(dateEnd.getTime())) {
      endMonthCalendar.firstChild.innerText = dateEnd.toString().split(' ')[1];
      endDayCalendar.innerText = dateEnd.toString().split(' ')[2];
    }
  };

  const calendarBox = document.querySelector('.calendar-box');
  if (calendarBox) {
    changeDate();
    startInput.addEventListener('change', () => {
      changeDate();
    });
  }
};

export default calendar;
