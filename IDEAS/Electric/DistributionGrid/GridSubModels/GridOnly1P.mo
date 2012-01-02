within IDEAS.Electric.DistributionGrid.GridSubModels;
model GridOnly1P

public
replaceable parameter IDEAS.Electric.Data.Interfaces.GridType
                                             grid( Pha=1)
    "Choose a grid Layout (with 3 phaze values)"
                                                annotation(choicesAllMatching = true);

  IDEAS.Electric.DistributionGrid.Components.Branch branch[Nodes](R=
        Modelica.ComplexMath.real(Z), X=Modelica.ComplexMath.imag(Z));

  Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin
                  TraPin
    annotation (Placement(transformation(extent={{-110,30},{-90,50}})));

  Modelica.Electrical.QuasiStationary.SinglePhase.Interfaces.PositivePin[
                                 Nodes] node
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

  Modelica.SIunits.ActivePower PGriTot;
  Modelica.SIunits.ComplexPower SGriTot;
  Modelica.SIunits.ReactivePower QGriTot;

//parameter Boolean Loss = true
//    "if true, PLosBra and PGriLosTot gives branch and Grid losses";
output Modelica.SIunits.ActivePower PLosBra[Nodes];
output Modelica.SIunits.ActivePower PGriLosTot;

output Modelica.SIunits.Voltage Vabs[Nodes];

protected
parameter Integer T_matrix[Nodes,Nodes] = grid.T_matrix;
parameter Modelica.SIunits.ComplexImpedance[Nodes] Z = grid.Z;
parameter Integer Nodes=grid.n;

equation
  connect(branch[1].pin_p,TraPin);
for x in 1:Nodes loop
  for y in 1:Nodes loop
        if T_matrix[x,y]==1 then
          connect(branch[x].pin_p,node[y]);
        elseif T_matrix[x,y]==-1 then
          connect(branch[x].pin_n,node[y]);
        end if;
  end for;

end for;

for x in 1:Nodes loop
    Vabs[x] = Modelica.ComplexMath.'abs'(node[x].v);
end for;

//if Loss then
  for x in 1:Nodes loop
    PLosBra[x] = branch[x].R*(Modelica.ComplexMath.'abs'(branch[x].i))^2;
  end for;
  PGriLosTot = ones(Nodes)*PLosBra;
//end if;

  SGriTot = branch[1].pin_p.v*Modelica.ComplexMath.conj(branch[1].pin_p.i);
  PGriTot = Modelica.ComplexMath.real(SGriTot);
  QGriTot = Modelica.ComplexMath.imag(SGriTot);
  annotation (Diagram(graphics), Icon(graphics={Bitmap(extent={{-100,100},{102,
              -100}}, fileName=
              "modelica://ELECTA/icon-ssnav-08-electricity.jpg")}));
end GridOnly1P;