within IDEAS.DistrictHeating.HeatingSystems;
package Control
  partial model PartialControl

   Modelica.Blocks.Interfaces.RealInput u
      annotation (Placement(transformation(extent={{-132,-20},{-92,20}})));

      Modelica.Blocks.Interfaces.RealOutput y
      annotation (Placement(transformation(extent={{98,-10},{118,10}})));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}}), graphics));
  end PartialControl;

  model Hysteresis
    extends PartialControl;

    parameter Real uLow;
    parameter Real uHigh;
    parameter Real realTrue;
    parameter Real realFalse;

    parameter Boolean release=false;

    parameter Real threshold=0.0001 "Greater than threshold";

    Modelica.Blocks.Logical.Hysteresis hysteresis(
      uLow=uLow,
      uHigh=uHigh,
      pre_y_start=true)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-66,-6})));
    Modelica.Blocks.Math.BooleanToReal booleanToReal(
      realTrue=realTrue,
      realFalse=realFalse)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-18,-6})));

    Modelica.Blocks.Interfaces.RealInput u1 if release
      annotation (Placement(transformation(extent={{-20,-20},{20,20}},
          rotation=270,
          origin={0,108})));

    Modelica.Blocks.Math.Product product if release
      annotation (Placement(transformation(extent={{36,-10},{56,10}})));
    Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(
      threshold=threshold) if release
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=270,
          origin={0,70})));
    Modelica.Blocks.Math.BooleanToReal booleanToReal1 if release
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=270,
          origin={0,26})));
  equation
    connect(hysteresis.y, booleanToReal.u) annotation (Line(
        points={{-55,-6},{-30,-6}},
        color={255,0,255},
        smooth=Smooth.None));
    connect(u, hysteresis.u) annotation (Line(
        points={{-112,0},{-88,0},{-88,-6},{-78,-6}},
        color={0,0,127},
        smooth=Smooth.None));

    if release then
      connect(booleanToReal.y, product.u2) annotation (Line(
        points={{-7,-6},{34,-6}},
        color={0,0,127},
        smooth=Smooth.None));
      connect(product.y, y) annotation (Line(
        points={{57,0},{108,0}},
        color={0,0,127},
        smooth=Smooth.None));
      connect(greaterThreshold.y, booleanToReal1.u) annotation (Line(
        points={{-1.9984e-015,59},{0,59},{0,38},{2.22045e-015,38}},
        color={255,0,255},
        smooth=Smooth.None));
      connect(booleanToReal1.y, product.u1) annotation (Line(
        points={{0,15},{0,6},{34,6}},
        color={0,0,127},
        smooth=Smooth.None));
      connect(u1, greaterThreshold.u) annotation (Line(
        points={{0,108},{0,82}},
        color={0,0,127},
        smooth=Smooth.None));
    else
      connect(y, booleanToReal.y);
    end if;
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), Icon(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                                                 graphics={
                                           Rectangle(
            extent={{-100,100},{100,-100}},
            fillColor={210,210,210},
            lineThickness=5.0,
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Raised),
          Polygon(
            points={{-80,90},{-88,68},{-72,68},{-80,90}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,68},{-80,-29}}, color={192,192,192}),
          Polygon(
            points={{92,-29},{70,-21},{70,-37},{92,-29}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-79,-29},{84,-29}}, color={192,192,192}),
          Line(points={{-79,-29},{41,-29}}, color={0,0,0}),
          Line(points={{-15,-21},{1,-29},{-15,-36}}, color={0,0,0}),
          Line(points={{41,51},{41,-29}}, color={0,0,0}),
          Line(points={{33,3},{41,22},{50,3}}, color={0,0,0}),
          Line(points={{-49,51},{81,51}}, color={0,0,0}),
          Line(points={{-4,59},{-19,51},{-4,43}}, color={0,0,0}),
          Line(points={{-59,29},{-49,11},{-39,29}}, color={0,0,0}),
          Line(points={{-49,51},{-49,-29}}, color={0,0,0}),
          Text(
            extent={{-92,-49},{-9,-92}},
            lineColor={192,192,192},
            textString="%uLow"),
          Text(
            extent={{2,-49},{91,-92}},
            lineColor={192,192,192},
            textString="%uHigh"),
          Rectangle(extent={{-91,-49},{-8,-92}}, lineColor={192,192,192}),
          Line(points={{-49,-29},{-49,-49}}, color={192,192,192}),
          Rectangle(extent={{2,-49},{91,-92}}, lineColor={192,192,192}),
          Line(points={{41,-29},{41,-49}}, color={192,192,192})}));
  end Hysteresis;
end Control;
