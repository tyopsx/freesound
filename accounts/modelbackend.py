#
# Freesound is (c) MUSIC TECHNOLOGY GROUP, UNIVERSITAT POMPEU FABRA
#
# Freesound is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# Freesound is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# Authors:
#     See AUTHORS file.
#

from django.contrib.auth.models import User
from django.contrib.auth.backends import ModelBackend


class CustomModelBackend(ModelBackend):

    def authenticate(self, request, username=None, password=None, **kwargs):
        """ authenticate against case insensitive username """

        if '@' in username:
            # In this case, user is most probably using email+password pair to login
            # Try to get user object from password and check password
            try:
                user = User.objects.get(email__iexact=username)
                if user.check_password(password):
                    return user
            except User.DoesNotExist:
                # If user was not find by email, it could be that user who's logging in has
                # '@' characters in username and therefore is trying normal username+password login
                pass

        # Do normal username+password login check
        try:
            user = User.objects.get(username__iexact=username)
            if user.check_password(password):
                return user
        except User.DoesNotExist:
            pass

        return None
