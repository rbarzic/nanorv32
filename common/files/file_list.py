# functions to help building list of files needed by the various tools


def get_file_list(l, context, target):
    """
    Return a file list depending of the target, and update pathes
    depending of context parameter

    @param l: the definition for all the files/directory  used by the project
    @type l: list of dictionary
    @param context: define the pathes for the files
    @type context: string
    @param target: for which target we want the file/directory list
    @type target: string
    @return: list of file matching the context
    @rtype: list of string
    """
    result = list()
    for f in l:
        filename = f['file']
        f_targets = f['targets']
        list_of_file_targets = set(f_targets.split(','))
        list_of_wanted_targets = set(target.split(','))
        if set.intersection(list_of_file_targets, list_of_wanted_targets):  # noqa
        #  if target in list_of_target:
            result.append(filename.format(**context))
    return result


def get_dir_list(ll, context, target):
    """
    Return a directory list depending of the target, and update pathes
    depending of context parameter

    @param l: the definition for all the directories  used by the project
    @type l: list of dictionary
    @param context: define the pathes for the files
    @type context: string
    @param target: for which target we want the directory list
    @type target: string
    @return: list of file matching the context
    @rtype: list of string
    """
    result = list()
    for dd in ll:
        dirname = dd['dir']
        d_targets = dd['targets']
        # print ">>>>>>" + dirname
        list_of_dir_targets = set(d_targets.split (','))
        list_of_wanted_targets = set(target.split (','))

        if set.intersection(list_of_dir_targets, list_of_wanted_targets) is not None:  # noqa
            result.append(dirname.format(**context))
    return result
