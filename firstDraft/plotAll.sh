# Files that need to be re-made

gmtPlot data/plotOrographyl2.gmt
gmtPlot data/plotOrographylinf.gmt

cd $HOME/OpenFOAM/hilary-3.0.1/run/solidBodyRotationOnPlane
gmtPlot runAll/plotl2ConvergenceC1.gmt
gmtPlot runAll/plotl2ConvergenceC10.gmt
gmtPlot runAll/plotlinfConvergenceC1.gmt
gmtPlot runAll/plotlinfConvergenceC10.gmt
gmtPlot runAll/plotl2_dt.gmt
gmtPlot runAll/plotlinf_dt.gmt
cd -

cd $HOME/OpenFOAM/hilary-3.0.1/run/deformingAdvectionCyclic
gmtPlot runAll/plotl2_c1.gmt
gmtPlot runAll/plotlinf_c1.gmt
gmtPlot runAll/plotl2_c10.gmt
gmtPlot runAll/plotlinf_c10.gmt
gmtPlot runAll/plotl2_dt.gmt
gmtPlot runAll/plotlinf_dt.gmt
cd -

cd YumengsGraphics/deformationalData
./plots.sh
cd -
