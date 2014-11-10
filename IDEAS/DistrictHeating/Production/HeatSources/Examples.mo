within IDEAS.DistrictHeating.Production.HeatSources;
package Examples
  //Examples
  extends Modelica.Icons.ExamplesPackage;
  model FunctionModel "Test for the Poly2ndDegree3Inputs function"

    //Parameters
    parameter Real x;
    parameter Real y;
    parameter Real z;

    parameter Real beta[10];
    parameter Integer powers[10,4];

    //Variables
    Real result;

  equation
    result = IDEAS.DistrictHeating.Production.HeatSources.Poly2ndDegree3Inputs(
      X=x, Y=y, Z=z, beta=beta, powers=powers);

  end FunctionModel;

  model FunctionTest "Test using the function model"
    //Extensions
    extends Modelica.Icons.Example;

    FunctionModel functionModel(
      beta={1.10801352268,-0.00139459489796,7.84565873015e-05,-0.00560282142857,
          -4.15816326533e-07,3.93071428571e-07,1.587e-05,-3.8671201814e-08,-4.29261904762e-07,
          2.67019047619e-05},
      powers={{2,0,0,0},{1,1,0,0},{1,0,1,0},{1,0,0,1},{0,2,0,0},{0,1,1,0},{0,1,
          0,1},{0,0,2,0},{0,0,1,1},{0,0,0,2}},
      z=60,
      x=0,
      y=0) annotation (Placement(transformation(extent={{-10,-6},{10,14}})));
  end FunctionTest;
end Examples;
