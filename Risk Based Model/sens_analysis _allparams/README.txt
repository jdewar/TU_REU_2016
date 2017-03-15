Very brief description of this code:
  test_run.m will fill the data/ folder with .mat files, .pdf plots, and a latex sensitivity table, run it.

  the ode and the blackbox will differ between users.
  they are located in lib/ode/ and each of those files has commentary on their purpose.

Issues:
  if the code dies and complains about workers/pool/parallel, change the 'parfor' to 'for' in lib/generate_data.m

  if the code complains about ghostscript, either try to install or comment out the call to export_fig in lib/generate_plots.m
