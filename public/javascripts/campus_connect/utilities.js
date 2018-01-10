var CampusConnect = CampusConnect || {};
CampusConnect.Utilities = function () {
    var signOut = function (token) {
        $.ajax({url: "/users/sign_out",
                success: function (result) {
                    window.location.replace('/');
                    },
                type: 'delete',
                data: {authenticity_token: token}
                });
    };
    return {
        signOut: signOut
    };
}();
