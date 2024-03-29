# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/roxterm/roxterm-1.22.2.ebuild,v 1.1 2011/07/09 17:05:25 ssuominen Exp $

EAPI=4
inherit gnome2-utils

DESCRIPTION="A terminal emulator designed to integrate with the ROX environment"
HOMEPAGE="http://roxterm.sourceforge.net/"
SRC_URI="mirror://sourceforge/roxterm/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gtk3"
#EGIT_BOOTSTRAP="bootstrap.sh"

RDEPEND="dev-libs/dbus-glib
	>=dev-libs/glib-2.16
	!gtk3? ( x11-libs/gtk+:2 )
	gtk3? ( x11-libs/gtk+:3 )
	x11-libs/libICE
	x11-libs/libSM
	!gtk3? ( >=x11-libs/vte-0.11.11:0 )
	gtk3? ( >=x11-libs/vte-0.27.3:2.90 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS=( AUTHORS ChangeLog NEWS README TODO )

src_prepare() {
	sed -i -e 's:TerminalEmulator:System;&:' roxterm.desktop || die
#	touch Help/lib/roxterm_logo.png
#	touch Help/lib/logo_text.png
#	touch Help/lib/favicon.ico
}

src_configure() {
	econf $(use_enable gtk3) --htmldir=/usr/share/doc/${PF}/html
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
