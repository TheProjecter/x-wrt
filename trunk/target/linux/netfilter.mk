# $Id: netfilter.mk 4597 2006-08-18 15:37:51Z florian $

IPT_CONNTRACK-m :=
IPT_CONNTRACK-$(CONFIG_IP_NF_MATCH_CONNTRACK) += ipt_conntrack
IPT_CONNTRACK-$(CONFIG_IP_NF_MATCH_HELPER) += ipt_helper
IPT_CONNTRACK-$(CONFIG_IP_NF_MATCH_CONNMARK) += ipt_connmark
IPT_CONNTRACK-$(CONFIG_IP_NF_TARGET_CONNMARK) += ipt_CONNMARK
IPT_CONNTRACK-$(CONFIG_IP_NF_MATCH_STATE) += ipt_state
IPT_CONNTRACK-$(CONFIG_IP_NF_MATCH_CONNBYTES) += ipt_connbytes

IPT_EXTRA-m :=
IPT_EXTRA-$(CONFIG_IP_NF_MATCH_LIMIT) += ipt_limit
IPT_EXTRA-$(CONFIG_IP_NF_TARGET_LOG) += ipt_LOG
IPT_EXTRA-$(CONFIG_IP_NF_MATCH_MULTIPORT) += ipt_multiport
IPT_EXTRA-$(CONFIG_IP_NF_MATCH_OWNER) += ipt_owner
IPT_EXTRA-$(CONFIG_IP_NF_MATCH_PHYSDEV) += ipt_physdev
IPT_EXTRA-$(CONFIG_IP_NF_MATCH_PKTTYPE) += ipt_pkttype
IPT_EXTRA-$(CONFIG_IP_NF_MATCH_RECENT) += ipt_recent
IPT_EXTRA-$(CONFIG_IP_NF_TARGET_REJECT) += ipt_REJECT

IPT_FILTER-m :=
IPT_FILTER-$(CONFIG_IP_NF_MATCH_IPP2P) += ipt_ipp2p
IPT_FILTER-$(CONFIG_IP_NF_MATCH_LAYER7) += ipt_layer7

IPT_IMQ-m :=
IPT_IMQ-$(CONFIG_IP_NF_TARGET_IMQ) += ipt_IMQ

IPT_IPOPT-m :=
IPT_IPOPT-$(CONFIG_IP_NF_TARGET_CLASSIFY) += ipt_CLASSIFY
IPT_IPOPT-$(CONFIG_IP_NF_MATCH_DSCP) += ipt_dscp
IPT_IPOPT-$(CONFIG_IP_NF_TARGET_DSCP) += ipt_DSCP
IPT_IPOPT-$(CONFIG_IP_NF_MATCH_ECN) += ipt_ecn
IPT_IPOPT-$(CONFIG_IP_NF_TARGET_ECN) += ipt_ECN
IPT_IPOPT-$(CONFIG_IP_NF_MATCH_LENGTH) += ipt_length
IPT_IPOPT-$(CONFIG_IP_NF_MATCH_MAC) += ipt_mac
IPT_IPOPT-$(CONFIG_IP_NF_MATCH_MARK) += ipt_mark
IPT_IPOPT-$(CONFIG_IP_NF_TARGET_MARK) += ipt_MARK
IPT_IPOPT-$(CONFIG_IP_NF_MATCH_TCPMSS) += ipt_tcpmss
IPT_IPOPT-$(CONFIG_IP_NF_TARGET_TCPMSS) += ipt_TCPMSS
IPT_IPOPT-$(CONFIG_IP_NF_MATCH_TOS) += ipt_tos
IPT_IPOPT-$(CONFIG_IP_NF_TARGET_TOS) += ipt_TOS
IPT_IPOPT-$(CONFIG_IP_NF_MATCH_TTL) += ipt_ttl
IPT_IPOPT-$(CONFIG_IP_NF_TARGET_TTL) += ipt_TTL
IPT_IPOPT-$(CONFIG_IP_NF_MATCH_UNCLEAN) += ipt_unclean

IPT_IPSEC-m :=
IPT_IPSEC-$(CONFIG_IP_NF_MATCH_AH_ESP) += ipt_ah ipt_esp

IPT_NAT-m :=
IPT_NAT-$(CONFIG_IP_NF_NAT) += ipt_SNAT ipt_DNAT
IPT_NAT-$(CONFIG_IP_NF_TARGET_MASQUERADE) += ipt_MASQUERADE
IPT_NAT-$(CONFIG_IP_NF_TARGET_MIRROR) += ipt_MIRROR
IPT_NAT-$(CONFIG_IP_NF_TARGET_REDIRECT) += ipt_REDIRECT

IPT_NAT_H323-m := 
IPT_NAT_H323-$(CONFIG_IP_NF_H323) += ip_conntrack_h323
IPT_NAT_H323-$(CONFIG_IP_NF_NAT_H323) += ip_nat_h323

IPT_NAT_PPTP-m +=
IPT_NAT_PPTP-$(CONFIG_IP_NF_PPTP) += ip_conntrack_pptp
IPT_NAT_PPTP-$(CONFIG_IP_NF_NAT_PPTP) += ip_nat_pptp

IPT_NAT_RTSP-m :=
IPT_NAT_RTSP-$(CONFIG_IP_NF_RTSP) += ip_conntrack_rtsp
IPT_NAT_RTSP-$(CONFIG_IP_NF_NAT_RTSP) += ip_nat_rtsp

IPT_NAT_EXTRA-m := 
IPT_NAT_EXTRA-$(CONFIG_IP_NF_AMANDA) += ip_conntrack_amanda
IPT_NAT_EXTRA-$(CONFIG_IP_NF_CT_PROTO_GRE) += ip_conntrack_proto_gre
IPT_NAT_EXTRA-$(CONFIG_IP_NF_NAT_PROTO_GRE) += ip_nat_proto_gre
IPT_NAT_EXTRA-$(CONFIG_IP_NF_NAT_SNMP_BASIC) += ip_nat_snmp_basic
IPT_NAT_EXTRA-$(CONFIG_IP_NF_TFTP) += ip_conntrack_tftp
IPT_NAT_EXTRA-$(CONFIG_IP_NF_NAT_TFTP) += ip_nat_tftp

IPT_QUEUE-m :=
IPT_QUEUE-$(CONFIG_IP_NF_QUEUE) += ip_queue

IPT_ULOG-m :=
IPT_ULOG-$(CONFIG_IP_NF_TARGET_ULOG) += ipt_ULOG

IPT_BUILTIN := ipt_standard
IPT_BUILTIN += ipt_icmp ipt_tcp ipt_udp
IPT_BUILTIN += $(IPT_CONNTRACK-y)
IPT_BUILTIN += $(IPT_EXTRA-y)
IPT_BUILTIN += $(IPT_FILTER-y)
IPT_BUILTIN += $(IPT_IMQ-y)
IPT_BUILTIN += $(IPT_IPOPT-y)
IPT_BUILTIN += $(IPT_IPSEC-y)
IPT_BUILTIN += $(IPT_NAT-y)
IPT_BUILTIN += $(IPT_ULOG-y)
