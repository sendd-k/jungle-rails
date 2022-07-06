describe("Home Page Tests", () => {
  beforeEach(() => {
    cy.request("/cypress_rails_reset_state");
  });
  it("Visits Home Page", () => {
    cy.visit("http://localhost:3000");
  });

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 12);
  });
});
