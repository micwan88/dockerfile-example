FROM jupyter/datascience-notebook

ARG NB_USER="jovyan"
ARG NB_UID="1000"

USER $NB_UID

RUN conda install --update-deps --quiet --yes \
	'r-rmysql' \
	'r-rmariadb' && \
	conda clean -tipsy && \
	fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER
