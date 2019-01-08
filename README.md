# Project Description
This project is a community effort to write TListLabelDataProvider implementations for usage with reporting tool combit List & Label. While the support for .NET has been around a long time, we're trying to build a similar ecosystem for Delphi through this project. Any help is greatly appreciated.

For a fully functional free 30-day trial version and further information about reporting tool List & Label 
please visit: https://www.combit.net/en/reporting-tool/

# What's Available So Far
The sources feature a new VCL component that uses the data provider interface. This enables a number of great features that were previously unavailable to Delphi developers using our "old" databound component:

* Multiple report containers
* Nested tables
* Databound report parameters
* Expandable regions in tables and crosstabs
* Interactive sorting in table headers

A sample showing how to use the component to bind to FireDAC data is also included. You should be able to bind to Oracle, MS SQL Server, SQLite, DB2, MySQL, PostgreSQL to name just a few. 

Copy the contents of this repository to "...\Program Files(x86)\combit\LL??\Samples\Delphi\FireDAC"

# How Can I Help?

We're happy to receive pull requests. Fields of interest include

* make sure the component is "Delphi-like"
* support label projects
* support DesignerFunctions and DesignerObjects
* add additional data providers to bind to CSV, XML, JSON etc.

# Why Bother?
If you're using List & Label with Delphi, you'll have encountered a set of restrictions this project is aiming to remove:

* Multiple report containers
* Support for FireDAC instead of BDE
* Nested tables
* Keep blocks together

A big special thank you goes to Andreas Müller of Nord-Vision IT - his contributions to this project were invaluable. Any feedback as well as additional contributions are very welcome, just contact the project's administrator.