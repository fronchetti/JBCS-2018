# JBCS-2018
In this repository you will find all the necessary steps to replicate the method available in the paper "Who Drives Company-Owned OSS Projects: Internals or Externals Members?", published at JBCS 2018.

## Reproducing the dataset:
If you want to create your own version of the dataset execute the file "<i>get_data.py</i>" [[1]](https://github.com/fronchetti/JBCS-2018/blob/master/get_data.py) using Python 2.7. After the script execution, all the files will be saved in a folder called "Dataset", and you may need to allow this process in your system. We have already made available a ready copy of this folder in this repository [[2]](https://github.com/fronchetti/JBCS-2018/tree/master/Dataset). Feel free to add new projects to the dataset during the process execution by adding them in line 410 of "<i>get_data.py</i>".

### Dataset structure:
⋅⋅* Dataset: <br>
⋅⋅*⋅⋅*⋅⋅* Project: <br>
⋅⋅*⋅⋅*⋅⋅*⋅⋅*⋅⋅* casual_contributors.csv (General information about casual contributors in the project)<br>
⋅⋅*⋅⋅*⋅⋅*⋅⋅*⋅⋅* external_contributors.csv (General information about external contributors in the project)<br>
⋅⋅*⋅⋅*⋅⋅*⋅⋅*⋅⋅* closed_pull_requests_summary.csv (General information about closed pull requests)<br>
⋅⋅*⋅⋅*⋅⋅*⋅⋅*⋅⋅* merged_pull_requests_summary.csv (General information about merged pull requests)<br>
⋅⋅*⋅⋅*⋅⋅*⋅⋅*⋅⋅* merged_pull_requests_reviews.csv (General information about reviews in merged pull requests)<br>
⋅⋅*⋅⋅*⋅⋅*⋅⋅*⋅⋅* pull_requests_per_month.csv (Monthly distribution of pull-requests open, closed and merged)<br>

### Reproducing images and statistical analysis:
All the analysis made in this paper, including the images, can be reproduced by executing the files available in the Scripts folder [[3]](https://github.com/fronchetti/JBCS-2018/tree/master/Scripts). Use the R language to execute it. During the execution, a set of images will be saved in a "Figures" folder, and you may need to allow it in your system [[4]](https://github.com/fronchetti/JBCS-2018/tree/master/Figures).

### Author Notes:
The "Crawler" folder contains the back-end scripts used to extract data from the GitHub API. Feel free to use the scripts of this folder in your methodology.

If you need any support:
Send us an e-mail: fronchetti at usp . br


