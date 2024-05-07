/// <reference types="cypress" />

describe('jungle store', () => {
  before(() => {
    // Cypress starts out with a blank slate for each test
    // so we must tell it to visit our website with the `cy.visit()` command.
    // Since we want to visit the same URL at the start of all our tests,
    // we include it in our beforeEach function so that it runs before each test
    cy.visit('http://localhost:3000/');
  });
  describe('home page', () => {
    it('There is products on the page', () => {
      cy.get('.products article').should('be.visible');
    });
    describe('clicking on login', () => {
      it('displays login page', () => {
        cy.contains('Login').click();
        cy.get('.user-login').should('be.visible');
      });
      describe('filling correct login details and clicking submit', () => {
        it('returns to home page', () => {
          cy.get('#email').type('test@test.com');
          cy.get('#password').type('tester');
          cy.contains('Submit').click();
          cy.get('.products article').should('be.visible');
          cy.contains('Logout').should('exist');
        });
      });
    });
  });
});
