const error = () => {
  if (document.querySelector('.stack-container')) {
    const stackContainer = document.querySelector('.stack-container');
    const cardNodes = document.querySelectorAll('.card-container');
    const perspecNodes = document.querySelectorAll('.perspec');
    const perspec = document.querySelector('.perspec');
    const card = document.querySelector('.card');

    let counter = stackContainer.children.length;

    // function to generate random number
    const randomIntFromInterval = (min, max) =>
      Math.floor(Math.random() * (max - min + 1) + min);

    // after tilt animation, fire the explode animation
    card.addEventListener('animationend', () => {
      perspecNodes.forEach((elem, index) => {
        elem.classList.add('explode');
      });
    });

    // after explode animation do a bunch of stuff
    perspec.addEventListener('animationend', (e) => {
      if (e.animationName === 'explode') {
        cardNodes.forEach((elem, index) => {
          // add hover animation class
          elem.classList.add('pokeup');

          // add event listner to throw card on click
          elem.addEventListener('click', () => {
            const updown = [800, -800];
            const randomY = updown[Math.floor(Math.random() * updown.length)];
            const randomX = Math.floor(Math.random() * 1000) - 1000;
            elem.style.transform = `translate(${randomX}px, ${randomY}px) rotate(-540deg)`;
            elem.style.transition = 'transform 1s ease, opacity 2s';
            elem.style.opacity = '0';
            counter--;
            if (counter === 0) {
              stackContainer.style.width = '0';
              stackContainer.style.height = '0';
            }
          });

          // generate random number of lines of code between 4 and 10 and add to each card
          const numLines = randomIntFromInterval(5, 10);

          // loop through the lines and add them to the DOM
          for (let index = 0; index < numLines; index++) {
            const lineLength = randomIntFromInterval(25, 97);
            const node = document.createElement('li');
            node.classList.add(`node-${index}`);
            elem
              .querySelector('.code ul')
              .appendChild(node)
              .setAttribute('style', `--linelength: ${lineLength}%;`);

            // draw lines of code 1 by 1
            if (index == 0) {
              elem
                .querySelector(`.code ul .node-${index}`)
                .classList.add('writeLine');
            } else {
              elem
                .querySelector(`.code ul .node-${index - 1}`)
                .addEventListener('animationend', (e) => {
                  elem
                    .querySelector(`.code ul .node-${index}`)
                    .classList.add('writeLine');
                });
            }
          }
        });
      }
    });
  }
};

export default error;
