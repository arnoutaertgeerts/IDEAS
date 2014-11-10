within IDEAS.DistrictHeating.Production;
model PolynomialProduction
  "Production model based on a polynomial function derived from performance data"

  //Extensions
  extends IDEAS.DistrictHeating.Production.BaseClasses.PartialHeater(redeclare
      HeatSources.Polynomial heatSource(
      redeclare package Medium = Medium,
      beta=beta,
      data=data,
      powers=powers,
      QNom=QNom,
      UALoss=UALoss), redeclare Data.Polynomials.Boiler data);

  //Parameters
  parameter Real beta[10];
  parameter Integer powers[10,4];

equation
  PEl = 7 + heatSource.modulation/100*(33 - 7);
  PFuel = heatSource.PFuel;

end PolynomialProduction;
