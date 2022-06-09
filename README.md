# List & Label Delphi Data Providers
This repository is a community effort to write TListLabelDataProvider implementations for usage with the **List & Label Reporting Tool**.

While the support for .NET has been around a long time, we're trying to build a similar ecosystem for Delphi through this repository. Any help is greatly appreciated.

# What's Available so Far
The sources feature a new VCL component (using FireDAC) that uses the data provider interface. This enables a number of great features that were previously unavailable to Delphi developers using our "old" (BDE) databound component:

- Multiple report containers
- Nested tables
- Databound report parameters
- Expandable regions in tables and crosstabs
- Interactive sorting in table headers
- Support of DesignerFunctions and DesignerObjects
- Keep blocks together

Samples showing how to use the component to bind to FireDAC data are also included in the full product setup or here on [GitHub](https://github.com/combit/ll-samples/tree/main/Delphi/FireDAC/Samples). You should be able to bind to Oracle, MS SQL Server, SQLite, DB2, MySQL, PostgreSQL to name just a few. 

Copy the contents of this repository to your List & Label installation under "..\Samples\Delphi\FireDAC".

# Contributions
We're happy to receive pull requests for any improvements on this repository. Please make sure with every contribution that the component needs to be "Delphi-like".

Further fields of interest include:
- Add additional data providers to bind to CSV, XML, JSON etc.

A big special thank you goes to Andreas Müller of Nord-Vision IT - his contributions to this repository were invaluable.

# About List & Label and Where to Get
List & Label is our **Reporting Tool for Software Developers** for desktop, web and cloud applications. For further information and a fully functional free 30-day trial version please visit our [website](https://www.combit.com/reporting-tool/).

# Contact
Please contact us at [github@combit.com](mailto:github@combit.com) with any additional feedback.